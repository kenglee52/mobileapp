# AI Copilot Instructions for POS Mobile App

## Architecture Overview

This Flutter e-commerce POS app follows **Clean Architecture** (Domain-Driven Design) with three distinct layers:

### Layer Structure
- **Presentation** (`lib/features/presentation/`): UI pages, ViewModels (ChangeNotifier pattern)
- **Domain** (`lib/features/domain/`): Business logic, entities, repositories (interfaces), use cases
- **Data** (`lib/features/data/`): Remote data sources, repository implementations, models

### Data Flow Pattern
```
Pages → ViewModels (Provider) → Use Cases → Repositories → Remote Data Sources (HTTP)
```

**Key Pattern Example**: `ProductViewModel` → `GetProducts` use case → `ProductRepository` interface → `ProductRepositoryImpl` → `ProductRemoteDatasource`

## State Management & Dependency Injection

- **State Management**: `Provider` package with `ChangeNotifier`
  - All ViewModels extend `ChangeNotifier` and notify listeners on data changes
  - ViewModels are initialized in `main.dart` with `MultiProvider`
  - Access ViewModels via `context.watch<ViewModel>()` or `context.read<ViewModel>()`

- **Dependency Injection**: Manual constructor-based DI in `main.dart`
  - Repositories are instantiated with data sources
  - Use cases are instantiated with repositories
  - ViewModels are instantiated with use cases
  - No service locator pattern (GetIt) is used

## Essential CRUD Pattern

Every entity (Product, Category, Customer, Bill, Order) follows this pattern:

1. **Use Cases** (`domain/usecases/{entity}/`):
   - `Create{Entity}.dart`: Takes entity, calls repository
   - `Get{Entities}.dart`: Returns List<Entity>
   - `Get{Entity}ById.dart`: Takes int id
   - `Update{Entity}.dart`: Takes entity
   - `Delete{Entity}.dart`: Takes int id

2. **ViewModels** (`presentation/viewmodels/{entity}_view_model.dart`):
   - Store entity list and loading state
   - `loadEntities()`, `addEntity()`, `editEntity()`, `removeEntity()` methods
   - Call respective use cases and notify listeners

3. **Data Source** (`data/datasources/{entity}_remote_datasource.dart`):
   - HTTP calls using `http` package
   - Methods mirror use case names

## UI & Navigation

- Material Design with custom red theme (`primaryColor: 0xFFD32F2F`)
- Font: NotoSansLao (Lao language support)
- Entry point: `LoginPage` → Navigate to feature pages
- Pages use `Scaffold`, `AppBar` with Material styling
- ListView/Column-based layouts typical

## Key Dependencies

- `provider: ^6.1.5+1` - State management
- `http: ^1.6.0` - HTTP requests
- `carousel_slider: ^5.1.1` - Image carousel (home page)
- `cupertino_icons: ^1.0.8` - iOS icons
- `flutter_lints: ^5.0.0` - Code quality

## Important Project Conventions

1. **File Naming**: snake_case for files (e.g., `product_view_model.dart`)
2. **Class Naming**: PascalCase for classes
3. **Colors**: Hex codes used directly, stored in theme or constants
4. **Localization**: Text in Lao (ກະຕ່າຂອງຂ້ອຍ = "My Cart")
5. **Error Handling**: Minimal in current codebase; exceptions bubble up from HTTP calls
6. **Use Case Pattern**: Single responsibility - each use case does one operation

## Typical Development Workflow

1. **Add New Entity**:
   - Create entity in `domain/entities/{entity}.dart`
   - Create repository interface in `domain/repositories/{entity}_repository.dart`
   - Create use cases in `domain/usecases/{entity}/` folder
   - Create models in `data/models/{entity}_model.dart`
   - Create remote data source in `data/datasources/{entity}_remote_datasource.dart`
   - Create repository impl in `data/repositories/{entity}_repository_impl.dart`
   - Create ViewModel in `presentation/viewmodels/{entity}_view_model.dart`
   - Register in `main.dart` MultiProvider
   - Create pages in `presentation/pages/`

2. **Testing**: None currently implemented (no test files in test/ folder)
3. **Build Commands**: Standard Flutter commands (`flutter run`, `flutter build apk/ios`)

## Critical Implementation Details

- **Models**: Use `fromEntity()` and `toEntity()` for conversion between models and entities
- **Repository Pattern**: Implementations delegate to remote data sources (no local caching)
- **HTTP Endpoint Integration**: Remote data sources construct HTTP requests directly
- **State Lifecycle**: ViewModels are loaded on app startup via `..loadEntities()` in MultiProvider

## Pages Structure

Main pages follow pattern:
- Extend `StatefulWidget` or `StatelessWidget`
- Use `context.watch<ViewModel>()` to access state
- Build UI from ViewModel data
- Call ViewModel methods on user interaction (add, edit, delete)

See `CartPage` (local state with `AddToCart` controller) and product listing pages for examples.
