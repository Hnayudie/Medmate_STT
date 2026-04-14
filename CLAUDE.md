# MedMate STT — Code Generation Rules

## Architecture Overview

Clean Architecture với 3 layer: **Domain → Data → Presentation**.

```
API Response
    ↓
Raw Model (*Raw)     — data/model/
    ↓
Domain Entity        — domain/entity/
    ↓
UseCase              — domain/usecase/
    ↓
ViewModel            — presentation/page/.../view_model/
    ↓
Cubit State          — presentation/cubit/
    ↓
UI Widget            — presentation/page/
```

---

## Layer Rules

### Domain Layer
- Entity dùng `@freezed`, không có `fromJson`/`toJson`, không import data layer
- Repository là `abstract class` (interface only)
- UseCase return `Either<Exception, T>`, wrap try-catch bên trong Impl
- UseCase Impl dùng `@Injectable(as: AbsractUseCase)`

### Data Layer
- Raw Model (DTO) dùng `@freezed` + `@JsonSerializable`, có `fromJson()` và `toDomainObject()`
- DataSource chỉ return Raw model — **không bao giờ return Entity**
- Repository Impl làm mapping Raw → Entity, implement interface từ domain
- **Không import domain entity vào DataSource**

### Presentation Layer
- ViewModel dùng `@freezed`, có `factory fromDomain(Entity)` và computed properties nếu cần
- State dùng `@freezed` union với các variant: `primaryState`, `loadingState`, `errorState`
- Mỗi state variant chứa `viewModel` tương ứng
- Cubit dùng `@injectable`, inject UseCase, emit state
- Screen dùng `BlocBuilder` / `BlocConsumer`, không chứa business logic

---

## File Structure (ví dụ tính năng `GetRecordingDetail`)

```
lib/
├── domain/
│   ├── entity/recording/recording_detail.dart
│   ├── repository/recording/recording_repository.dart
│   └── usecase/recording/get_recording_detail_use_case.dart
│
├── data/
│   ├── model/recording/recording_detail_raw.dart
│   ├── datasource/remote/recording_remote_data_source.dart
│   └── repository/recording/recording_repository_impl.dart
│
└── features/recording_detail/
    ├── presentation/
    │   ├── cubit/
    │   │   ├── recording_detail_cubit.dart
    │   │   └── recording_detail_state.dart
    │   └── pages/
    │       ├── view_model/recording_detail_view_model.dart
    │       └── recording_detail_page.dart
```

---

## Code Templates

### Domain Entity
```dart
// domain/entity/{module}/{name}.dart
@freezed
class RecordingDetail with _$RecordingDetail {
  const factory RecordingDetail({
    @Default('') String id,
    @Default('') String title,
  }) = _RecordingDetail;
}
```

### Repository Interface
```dart
// domain/repository/{module}/{module}_repository.dart
abstract class RecordingRepository {
  Future<Either<Exception, RecordingDetail>> getRecordingDetail({required String id});
}
```

### UseCase
```dart
// domain/usecase/{module}/{name}_use_case.dart
abstract class GetRecordingDetailUseCase
    extends UseCase<RecordingDetail, GetRecordingDetailUseCaseParams> {}

@Injectable(as: GetRecordingDetailUseCase)
class GetRecordingDetailUseCaseImpl extends GetRecordingDetailUseCase {
  final RecordingRepository _repository;
  GetRecordingDetailUseCaseImpl(this._repository);

  @override
  Future<Either<Exception, RecordingDetail>> call(GetRecordingDetailUseCaseParams params) async {
    try {
      return Right(await _repository.getRecordingDetail(id: params.id));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
```

### Raw Model (DTO)
```dart
// data/model/{module}/{name}_raw.dart
@freezed
class RecordingDetailRaw with _$RecordingDetailRaw {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory RecordingDetailRaw({
    @JsonKey(name: 'Id') String? id,
    @JsonKey(name: 'Title') String? title,
  }) = _RecordingDetailRaw;

  factory RecordingDetailRaw.fromJson(Map<String, dynamic> json) =>
      _$RecordingDetailRawFromJson(json);
}

extension RecordingDetailRawX on RecordingDetailRaw {
  RecordingDetail toDomainObject() => RecordingDetail(
        id: id ?? '',
        title: title ?? '',
      );
}
```

### Remote DataSource
```dart
// data/datasource/remote/{module}_remote_data_source.dart
abstract class RecordingRemoteDataSource {
  Future<RecordingDetailRaw> getRecordingDetail({required String id});
}

@Injectable(as: RecordingRemoteDataSource)
class RecordingRemoteDataSourceImpl implements RecordingRemoteDataSource {
  final ApiClient _client;
  RecordingRemoteDataSourceImpl(this._client);

  @override
  Future<RecordingDetailRaw> getRecordingDetail({required String id}) =>
      _client.getRecordingDetail(id);
}
```

### Repository Impl
```dart
// data/repository/{module}/{module}_repository_impl.dart
@Injectable(as: RecordingRepository)
class RecordingRepositoryImpl implements RecordingRepository {
  final RecordingRemoteDataSource _dataSource;
  RecordingRepositoryImpl(this._dataSource);

  @override
  Future<Either<Exception, RecordingDetail>> getRecordingDetail({required String id}) async {
    try {
      final raw = await _dataSource.getRecordingDetail(id: id);
      return Right(raw.toDomainObject());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
```

### ViewModel
```dart
// presentation/page/{feature}/view_model/{feature}_view_model.dart
@freezed
class RecordingDetailViewModel with _$RecordingDetailViewModel {
  const factory RecordingDetailViewModel({
    @Default('') String id,
    @Default('') String title,
  }) = _RecordingDetailViewModel;

  factory RecordingDetailViewModel.fromDomain(RecordingDetail domain) =>
      RecordingDetailViewModel(
        id: domain.id,
        title: domain.title,
      );
}
```

### Cubit State
```dart
// presentation/cubit/{feature}/{feature}_state.dart
@freezed
abstract class RecordingDetailState with _$RecordingDetailState {
  factory RecordingDetailState.primaryState({
    @Default(RecordingDetailViewModel()) RecordingDetailViewModel viewModel,
  }) = RecordingDetailPrimaryState;

  factory RecordingDetailState.loadingState({
    @Default(RecordingDetailViewModel()) RecordingDetailViewModel viewModel,
  }) = RecordingDetailLoadingState;

  factory RecordingDetailState.errorState({
    @Default(RecordingDetailViewModel()) RecordingDetailViewModel viewModel,
    @Default('') String message,
  }) = RecordingDetailErrorState;
}
```

### Cubit
```dart
// presentation/cubit/{feature}/{feature}_cubit.dart
@injectable
class RecordingDetailCubit extends Cubit<RecordingDetailState> {
  final GetRecordingDetailUseCase _getRecordingDetailUseCase;

  RecordingDetailCubit(this._getRecordingDetailUseCase)
      : super(const RecordingDetailState.loadingState());

  Future<void> init(String id) async {
    emit(RecordingDetailState.loadingState(viewModel: state.viewModel));
    final result = await _getRecordingDetailUseCase.call(
      GetRecordingDetailUseCaseParams(id: id),
    );
    result.fold(
      (error) => emit(RecordingDetailState.errorState(
        viewModel: state.viewModel,
        message: error.toString(),
      )),
      (data) => emit(RecordingDetailState.primaryState(
        viewModel: RecordingDetailViewModel.fromDomain(data),
      )),
    );
  }
}
```

### Screen
```dart
// presentation/page/{feature}/{feature}_page.dart
class RecordingDetailPage extends StatelessWidget {
  const RecordingDetailPage({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<RecordingDetailCubit>()..init(id),
      child: const _RecordingDetailView(),
    );
  }
}

class _RecordingDetailView extends StatelessWidget {
  const _RecordingDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingDetailCubit, RecordingDetailState>(
      builder: (context, state) {
        return state.when(
          loadingState: (_) => const Center(child: CircularProgressIndicator()),
          errorState: (_, message) => Center(child: Text(message)),
          primaryState: (viewModel) => _buildContent(viewModel),
        );
      },
    );
  }
}
```

---

## After Generating Files

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Generates: `*.freezed.dart`, `*.g.dart`, `di.config.dart`

---

## Naming Conventions

| Type | Convention | Example |
|---|---|---|
| File | `snake_case` | `recording_detail_raw.dart` |
| Class | `PascalCase` | `RecordingDetailRaw` |
| Variable | `camelCase` | `recordingDetail` |
| Private field | `_camelCase` | `_repository` |
| UseCase params | `{Name}UseCaseParams` | `GetRecordingDetailUseCaseParams` |
| State variants | `{Name}PrimaryState` | `RecordingDetailPrimaryState` |
