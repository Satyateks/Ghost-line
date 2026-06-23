# Flutter Chat Application — Full Project Context

## 1. Project Overview

This project is a modern Flutter-based chat/social communication application. The complete UI is expected to be built from the provided Figma design with a pixel-perfect approach.

The application follows a modular architecture with GetX for state management, routing, dependency injection, and controller-based business logic.

The project must support both dark mode and light mode. Every screen should use the common theme, shared widgets, and utility classes created during the system design phase.

---

## 2. Core Project Requirements

### Main Requirements

- Flutter application based on Figma design.
- Pixel-perfect UI implementation.
- GetX for:
  - State management
  - Routing
  - Dependency injection
  - Controller lifecycle management
- Dark and light mode support.
- Reusable component-based design system.
- Clean module-wise folder structure.
- API-ready architecture using Dio.
- Auth interceptor for Bearer token.
- Centralized API error handling.
- No-internet handling with user notification.
- Responsive UI for all screen sizes.
- Dynamic data support for lists, chats, calls, posts, stories, and comments.

---

## 3. Main Technology Stack

| Area | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart |
| State Management | GetX |
| Routing | GetX Routing |
| API Client | Dio |
| Local Storage | SharedPreferences / GetStorage |
| Image Loading | cached_network_image |
| Video Playback | video_player |
| Sharing | share_plus |
| Internet Check | connectivity_plus |
| UI Style | Figma-based, modern, clean, responsive |
| Theme | Custom light and dark theme |

---

## 4. Recommended Folder Structure

```txt
lib/
 ├── main.dart
 │
 ├── core/
 │   ├── constants/
 │   │   ├── app_constants.dart
 │   │   ├── api_constants.dart
 │   │   └── asset_constants.dart
 │   │
 │   ├── theme/
 │   │   ├── app_theme.dart
 │   │   ├── app_colors.dart
 │   │   ├── app_text_styles.dart
 │   │   └── app_dimensions.dart
 │   │
 │   ├── widgets/
 │   │   ├── app_button.dart
 │   │   ├── app_text_field.dart
 │   │   ├── app_card.dart
 │   │   ├── app_loader.dart
 │   │   ├── app_empty_state.dart
 │   │   ├── app_cached_image.dart
 │   │   ├── app_bottom_sheet.dart
 │   │   └── app_icon_button.dart
 │   │
 │   ├── utils/
 │   │   ├── api_error_handler.dart
 │   │   ├── snackbar_helpers.dart
 │   │   ├── validators.dart
 │   │   ├── app_logger.dart
 │   │   └── date_time_utils.dart
 │   │
 │   ├── network/
 │   │   ├── network_controller.dart
 │   │   └── network_binding.dart
 │   │
 │   └── bindings/
 │       └── initial_binding.dart
 │
 ├── data/
 │   ├── services/
 │   │   ├── api_service.dart
 │   │   └── storage_service.dart
 │   │
 │   ├── repositories/
 │   │   ├── auth_repository.dart
 │   │   ├── chat_repository.dart
 │   │   ├── call_repository.dart
 │   │   └── updates_repository.dart
 │   │
 │   └── models/
 │
 ├── routes/
 │   ├── app_routes.dart
 │   └── app_pages.dart
 │
 └── modules/
     ├── auth/
     │   ├── bindings/
     │   ├── controllers/
     │   ├── models/
     │   ├── views/
     │   └── widgets/
     │
     ├── home/
     │   ├── bindings/
     │   ├── controllers/
     │   ├── views/
     │   └── widgets/
     │
     ├── chat/
     │   ├── bindings/
     │   ├── controllers/
     │   ├── models/
     │   ├── views/
     │   └── widgets/
     │
     ├── calls/
     │   ├── bindings/
     │   ├── controllers/
     │   ├── models/
     │   ├── views/
     │   └── widgets/
     │
     └── updates/
         ├── bindings/
         ├── controllers/
         ├── models/
         ├── repository/
         ├── views/
         └── widgets/
```

---

## 5. System Design Flow

The project should follow this development flow:

```txt
Figma Design
   ↓
Design System Setup
   ↓
Theme Setup
   ↓
Reusable Core Widgets
   ↓
Routing Setup
   ↓
API Service Setup
   ↓
Repository Layer
   ↓
Module-wise UI Screens
   ↓
GetX Controllers
   ↓
API Integration
   ↓
Testing and UI Refinement
```

---

## 6. Theme System

The whole app should use a centralized theme system. No screen should use random hardcoded UI values unless absolutely required.

### Theme Files

```txt
core/theme/
 ├── app_theme.dart
 ├── app_colors.dart
 ├── app_text_styles.dart
 └── app_dimensions.dart
```

### Theme Requirements

- Light theme and dark theme should both be defined.
- `Theme.of(context)` should be used inside widgets.
- Common colors should come from `AppColors`.
- Common text styles should come from `AppTextStyles`.
- Common spacing/radius values should come from `AppDimensions`.
- The design should remain consistent across all modules.

### Example Theme Usage

```dart
final theme = Theme.of(context);

Container(
  color: theme.scaffoldBackgroundColor,
  child: Text(
    "Hello",
    style: theme.textTheme.titleMedium,
  ),
);
```

---

## 7. Core Reusable Widgets

All screens should use shared widgets from `core/widgets`.

### Common Widgets

#### 1. AppButton

Used for primary and secondary actions.

Expected variants:

- Primary button
- Secondary button
- Outline button
- Loading button
- Disabled button

#### 2. AppTextField

Used for login, OTP, search, chat input, comment input, forms, etc.

Expected features:

- Prefix icon
- Suffix icon
- Validation
- Password visibility toggle
- Multiline support
- Theme-based background

#### 3. AppCard

Used for chat tiles, post cards, profile sections, settings cards, etc.

Expected features:

- Theme-based color
- Common border radius
- Shadow support
- Padding control

#### 4. AppCachedImage

Used for network image rendering.

Expected features:

- Placeholder
- Error widget
- Circle and rounded rectangle support
- Cached image support

#### 5. AppBottomSheet

Used for delete confirmation, share options, media picker, action menus, etc.

Expected features:

- Rounded top corners
- Close icon
- Keyboard-safe behavior
- Dynamic height
- Theme support

#### 6. AppLoader

Used during API calls.

#### 7. AppEmptyState

Used when no chats, calls, comments, posts, or stories are available.

#### 8. SnackBarHelpers

Used for success, error, warning, and info messages.

---

## 8. GetX Architecture

Each module should follow the GetX pattern:

```txt
View
 ↓
Controller
 ↓
Repository
 ↓
ApiService
 ↓
API
```

### Responsibilities

#### View

- Only UI rendering.
- Should not contain heavy business logic.
- Uses `Obx`, `GetBuilder`, or controller state values.

#### Controller

- Handles screen logic.
- Manages loading states.
- Calls repository methods.
- Updates observable variables.
- Handles UI events.

#### Repository

- Handles data-level operations.
- Calls API service.
- Maps API response to models.
- Keeps API logic separate from UI.

#### ApiService

- Handles Dio setup.
- Adds token headers.
- Handles GET, POST, PUT, DELETE methods.
- Uses centralized error handler.

---

## 9. Routing Structure

Routes should be centralized.

### `app_routes.dart`

```dart
class AppRoutes {
  static const splash = "/splash";
  static const login = "/login";
  static const home = "/home";
  static const chatRoom = "/chat-room";
  static const calls = "/calls";
  static const updates = "/updates";
  static const comments = "/comments";
}
```

### `app_pages.dart`

```dart
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.updates,
      page: () => UpdatesScreen(),
      binding: UpdatesBinding(),
    ),
    GetPage(
      name: AppRoutes.comments,
      page: () => CommentsScreen(),
      binding: UpdatesBinding(),
    ),
  ];
}
```

---

## 10. API Layer

### ApiService Requirements

The API service should use Dio and should include:

- Base URL
- Connect timeout
- Receive timeout
- Auth interceptor
- Bearer token support
- Common request methods
- Centralized error handling

### Important Dio + GetX Conflict

Dio and GetX both have a class named `Response`.

To avoid conflict, Dio should be imported with alias:

```dart
import 'package:dio/dio.dart' as dio;
```

Then use:

```dart
dio.Response response;
```

---

## 11. Auth Interceptor Flow

Expected flow:

```txt
API request starts
   ↓
Interceptor checks stored token
   ↓
If token exists, add Authorization header
   ↓
Request continues
   ↓
If API returns error, ApiErrorHandler processes it
```

### Header Example

```dart
headers: {
  "Authorization": "Bearer $token",
  "Accept": "application/json",
  "Content-Type": "application/json",
}
```

---

## 12. ApiErrorHandler

A centralized `ApiErrorHandler` should handle common Dio and API errors.

### Error Types

- No internet
- Timeout
- Unauthorized 401
- Bad request 400
- Forbidden 403
- Not found 404
- Server error 500
- Certificate error
- Unknown error

### Usage

```dart
try {
  final response = await apiService.get("/endpoint");
} catch (e) {
  final message = ApiErrorHandler.getErrorMessage(e);
  SnackBarHelpers.error(message);
}
```

---

## 13. No Internet Handling

The project should have network connectivity detection.

### Expected Flow

```txt
App starts
   ↓
NetworkController initializes
   ↓
Connectivity listener starts
   ↓
If internet is lost
   ↓
Show no internet snackbar/banner
   ↓
If internet comes back
   ↓
Show connected message or silently refresh data
```

### Suggested Placement

```txt
core/network/
 ├── network_controller.dart
 └── network_binding.dart
```

---

## 14. Auth Module Context

The auth screen should follow a glassmorphism design style.

### Auth Flow

```txt
Login Card
   ↓ Continue
OTP Card
   ↓ Continue
Username Card
```

Alternative path:

```txt
Login Card
   ↓ Create Account
Create Account Card
```

### Auth UI Requirements

- Single background screen.
- Bottom glass card changes based on selected step.
- Smooth animated transitions.
- Continue button controls flow.
- Create account button opens create account card.
- Theme-based but glass-style design.
- Responsive for all devices.

---

## 15. Home / Chat List Module

The home screen is the main chat list screen.

### Requirements

- App bar with title and actions.
- Search option.
- Tab bar / category filter.
- Chat list.
- Bottom navigation.
- Tap chat to open chat room.
- Long press or action button to open delete confirmation bottom sheet.
- Dynamic data.
- Dark/light support.
- Pixel-perfect according to Figma.

### Delete Chat Flow

```txt
User long presses chat
   ↓
Delete confirmation bottom sheet opens
   ↓
User confirms delete
   ↓
Controller removes chat or calls API
   ↓
List updates
```

---

## 16. Chat Room Module

The chat room screen should contain:

- Header with user image, name, status.
- Back button.
- Call/video call actions if required.
- Messages list.
- Sender and receiver bubbles.
- Time display.
- Message status.
- Input field.
- Attachment option.
- Send button.
- Dynamic keyboard-safe layout.
- Dark/light support.

### Chat Logic

```txt
Screen opens with chatId
   ↓
Controller loads messages
   ↓
User types message
   ↓
Send button calls sendMessage()
   ↓
Message added locally
   ↓
API/websocket integration later
```

---

## 17. Calls Module

The calls screen should contain:

- Recent call list.
- Incoming/outgoing/missed call indicators.
- Audio/video call icons.
- User avatar.
- Time/date.
- Clean modern UI.
- Dynamic list.
- Dark/light support.

---

## 18. Updates Module

The Updates module is the current active module.

It works like an Instagram-style updates feed.

### Updates Screen Flow

```txt
Updates screen opens
   ↓
Top horizontal story section appears
   ↓
First item is Add Story / Your Story
   ↓
Other users' stories appear after it
   ↓
Below stories, vertical post feed appears
   ↓
User can like, comment, or share posts
```

### Updates Screen UI

Top area:

- Add own story option.
- Other people’s story view options.
- Horizontal scroll.
- Circular story avatars.
- Viewed/unviewed story indicators.

Post area:

- User avatar and name.
- Post image or video.
- Post title.
- Post description.
- Like button.
- Comment button.
- Share button.
- Bookmark or more option if required.

### Post Actions

#### Like

```txt
User taps like
   ↓
Post liked/unliked
   ↓
Like count updates
   ↓
Later API: likePost(postId)
```

#### Comment

```txt
User taps comment
   ↓
Comments screen opens
   ↓
Post data passes as argument
```

#### Share

```txt
User taps share
   ↓
Native share sheet opens
   ↓
Post title/description/link can be shared
```

---

## 19. Comments Screen

Comment click opens a second screen.

### Comments Screen Requirements

- App bar with title.
- Post preview section.
- Comments list.
- Comment like option.
- Comment reply option.
- Nested replies display.
- Comment input at bottom.
- Keyboard-safe input area.
- Send button.
- Dark/light support.

### Comment Flow

```txt
Comments screen opens
   ↓
Controller loads comments for selected post
   ↓
User writes comment
   ↓
Send button adds comment
   ↓
Comment appears in list
```

### Reply Flow

```txt
User taps Reply
   ↓
Input field pre-fills @username
   ↓
User types reply
   ↓
Reply is added under selected comment
```

---

## 20. Updates Module Suggested Folder Structure

```txt
modules/updates/
 ├── bindings/
 │   └── updates_binding.dart
 │
 ├── controllers/
 │   └── updates_controller.dart
 │
 ├── models/
 │   ├── story_model.dart
 │   ├── post_model.dart
 │   └── comment_model.dart
 │
 ├── repository/
 │   └── updates_repository.dart
 │
 ├── views/
 │   ├── updates_screen.dart
 │   └── comments_screen.dart
 │
 └── widgets/
     ├── story_item.dart
     ├── post_card.dart
     ├── comment_item.dart
     ├── video_post_preview.dart
     └── story_viewer.dart
```

---

## 21. Updates Module API-Ready Methods

### Controller Methods

```dart
getStories()
addStory()
viewStory(String storyId)
getPosts()
likePost(String postId)
sharePost(PostModel post)
getComments(String postId)
addComment(String postId, String text)
likeComment(String commentId)
replyComment(String commentId, String text)
```

### Repository Methods

```dart
Future<List<StoryModel>> getStories();
Future<void> addStory(dynamic file);
Future<List<PostModel>> getPosts();
Future<void> likePost(String postId);
Future<List<CommentModel>> getComments(String postId);
Future<void> addComment(String postId, String text);
Future<void> replyComment(String commentId, String text);
```

---

## 22. Models Required for Updates Module

### StoryModel

Fields:

- id
- name
- image
- isOwnStory
- isViewed

### PostModel

Fields:

- id
- userName
- userImage
- title
- description
- mediaUrl
- isVideo
- isLiked
- likeCount
- commentCount

### CommentModel

Fields:

- id
- userName
- userImage
- comment
- isLiked
- likeCount
- replies

---

## 23. Current Issues Already Discussed

### 1. Dio Response Conflict

Problem:

```txt
The name 'Response' is defined in the libraries 'dio' and 'get'
```

Solution:

```dart
import 'package:dio/dio.dart' as dio;
```

Use:

```dart
dio.Response
```

---

### 2. Undefined SnackBarHelpers

Problem:

```txt
Undefined name 'SnackBarHelpers'
```

Solution:

Create `snackbar_helpers.dart` inside:

```txt
core/utils/snackbar_helpers.dart
```

Expected methods:

```dart
SnackBarHelpers.success("Message");
SnackBarHelpers.error("Message");
SnackBarHelpers.warning("Message");
SnackBarHelpers.info("Message");
```

---

### 3. Certificate Verify Failed

Problem:

```txt
HandshakeException: CERTIFICATE_VERIFY_FAILED
```

Possible reasons:

- Invalid SSL certificate.
- Self-signed certificate.
- Server certificate chain issue.
- Device date/time issue.

Important:

Do not permanently disable certificate validation in production.

---

### 4. Android NDK source.properties Missing

Problem:

```txt
NDK source.properties missing
```

Possible solution:

- Reinstall NDK from Android Studio SDK Manager.
- Delete broken NDK folder.
- Run `flutter doctor`.
- Set correct NDK version in `android/app/build.gradle`.

---

### 5. Login Button Not Responding

Possible checklist:

- Check `onPressed`.
- Check form validation.
- Check controller method.
- Check loading state.
- Check API call.
- Check route navigation.
- Check if button is covered by another widget.
- Check if `AbsorbPointer` or `IgnorePointer` is active.

---

### 6. Bottom Sheet Keyboard Issue

Problem:

Bottom sheet moves incorrectly or appears above keyboard.

Solution pattern:

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (_) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: YourBottomSheetContent(),
    );
  },
);
```

---

## 24. UI Design Rules

### General UI Rules

- Use Figma as source of truth.
- Keep spacing consistent.
- Use responsive layout.
- Avoid hardcoded widths.
- Use `Expanded`, `Flexible`, `LayoutBuilder`, and `MediaQuery` where needed.
- Use theme colors.
- Use reusable widgets.
- Keep UI clean and modular.
- Avoid putting business logic inside widgets.

### Dark/Light Rules

- Never use plain black/white directly everywhere.
- Use `theme.cardColor`, `theme.scaffoldBackgroundColor`, `theme.textTheme`, and `theme.colorScheme`.
- Icons should use `theme.iconTheme.color`.
- Borders should use `theme.dividerColor`.

---

## 25. Coding Standards

### File Naming

Use snake_case:

```txt
updates_screen.dart
updates_controller.dart
post_model.dart
comment_item.dart
```

### Class Naming

Use PascalCase:

```dart
UpdatesScreen
UpdatesController
PostModel
CommentItem
```

### Variable Naming

Use camelCase:

```dart
isLoading
postList
commentController
```

### Controller Variables

Use Rx variables:

```dart
final isLoading = false.obs;
final posts = <PostModel>[].obs;
final comments = <CommentModel>[].obs;
```

---

## 26. State Management Pattern

### Loading State

```dart
final isLoading = false.obs;
```

### List State

```dart
final posts = <PostModel>[].obs;
```

### Action State

```dart
void toggleLike(String postId) {
  final index = posts.indexWhere((post) => post.id == postId);
  if (index == -1) return;

  posts[index].isLiked = !posts[index].isLiked;
  posts.refresh();
}
```

---

## 27. Binding Pattern

Every module should have its own binding.

### Example

```dart
class UpdatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatesRepository>(
      () => UpdatesRepository(Get.find<ApiService>()),
    );

    Get.lazyPut<UpdatesController>(
      () => UpdatesController(Get.find<UpdatesRepository>()),
    );
  }
}
```

---

## 28. Main App Setup

`main.dart` should initialize services and routes.

### Expected Flow

```txt
WidgetsFlutterBinding.ensureInitialized()
   ↓
Initialize local storage
   ↓
Inject ApiService
   ↓
Inject NetworkController
   ↓
Run GetMaterialApp
```

### Example

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(const MyApp());
}
```

---

## 29. GetMaterialApp Setup

```dart
GetMaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Chat App",
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
  initialBinding: InitialBinding(),
  initialRoute: AppRoutes.login,
  getPages: AppPages.pages,
);
```

---

## 30. API Integration Plan

### Phase 1 — Static UI

- Build screens using dummy data.
- Match Figma.
- Test dark/light mode.
- Test scrolling, bottom sheet, navigation.

### Phase 2 — Local Controller Logic

- Like/unlike.
- Add comment.
- Reply comment.
- Delete chat.
- Search/filter.
- Loading and empty states.

### Phase 3 — API Integration

- Connect repository with ApiService.
- Replace dummy data with API response.
- Add model `fromJson` and `toJson`.
- Add error handling.
- Add token-based requests.
- Add no-internet guard.

### Phase 4 — Final Refinement

- Pixel-perfect fixes.
- Animation.
- Performance optimization.
- List pagination.
- Pull-to-refresh.
- Image/video caching improvements.

---

## 31. Module Development Order

Recommended order:

```txt
1. Core theme
2. Core widgets
3. Routing setup
4. API service
5. Auth module
6. Home / chat list
7. Chat room
8. Calls screen
9. Updates module
10. Comments screen
11. API integration
12. Final UI polish
```

---

## 32. Important Packages

```yaml
dependencies:
  flutter:
    sdk: flutter

  get: ^4.6.6
  dio: ^5.7.0
  shared_preferences: ^2.3.2
  connectivity_plus: ^6.1.0
  cached_network_image: ^3.4.1
  video_player: ^2.9.2
  share_plus: ^10.1.4
```

Use latest stable versions if required.

---

## 33. Final Architecture Summary

This project should be treated as a scalable production-ready Flutter application.

Main design principle:

```txt
Reusable Design System
   +
GetX Modular Architecture
   +
Dio Repository Pattern
   +
Theme-Based UI
   +
Pixel-Perfect Figma Implementation
```

Every new screen should follow the same rule:

```txt
View uses Widgets
Controller handles Logic
Repository handles Data
ApiService handles Network
Theme handles Design
```

---

## 34. Notes for Future Development

- Do not directly write API calls inside UI screens.
- Do not hardcode colors on every screen.
- Do not create duplicate button/textfield/card widgets inside modules.
- Use common widgets from `core/widgets`.
- Use bindings for dependency injection.
- Use route names from `AppRoutes`.
- Keep dummy data only until API is ready.
- Convert all API responses into proper models.
- Keep UI keyboard-safe.
- Keep all bottom sheets reusable and theme-based.
- Use pagination for large chat/post/comment lists.
- Use cached images for avatars and posts.
- For video posts, initialize and dispose video controllers properly.
- Use `dispose()` for TextEditingController and VideoPlayerController when needed.
- Keep business logic inside controllers only.

---

## 35. Current Active Work

The current active module is:

```txt
Updates Module
```

Current implementation target:

- Instagram-style stories.
- Own story add option.
- Other users' story viewing option.
- Scrollable post feed.
- Image/video posts.
- Like post.
- Open comments screen.
- Like comments.
- Reply to comments.
- Share post.
- Theme-based, clean UI.
- GetX controller-based logic.
- API-ready structure.

---

## 36. Custom Components aur Helper Files

Is project mein custom components aur helper files core folder ke andar organize kiye gaye hain.

### Custom Components (core/widgets/)

Ye components pure app mein reuse kiye jate hain:

- **app_button.dart** - Primary, secondary, outline, loading, aur disabled buttons ke liye
- **app_text_field.dart** - Login, OTP, search, chat input, comment input ke liye
- **app_card.dart** - Chat tiles, post cards, profile sections ke liye
- **app_loader.dart** - API calls ke dauran loading indication ke liye
- **app_empty_state.dart** - Jab koi chats, calls, comments, posts ya stories available na hon
- **app_cached_image.dart** - Network images ke liye with placeholder aur error handling
- **app_bottom_sheet.dart** - Delete confirmation, share options, media picker ke liye
- **app_icon_button.dart** - Custom icon buttons ke liye

### Helper Files (core/utils/)

- **api_error_handler.dart** - Centralized API error handling ke liye
- **snackbar_helpers.dart** - Success, error, warning, info messages ke liye
- **validators.dart** - Form validation ke liye
- **app_logger.dart** - Logging ke liye
- **date_time_utils.dart** - Date aur time formatting ke liye

### Network Files (core/network/)

- **network_controller.dart** - Internet connectivity check ke liye
- **network_binding.dart** - Network controller binding ke liye

### Theme Files (core/theme/)

- **app_theme.dart** - Light aur dark theme definitions
- **app_colors.dart** - Common colors (primary, secondary, background, etc.)
- **app_text_styles.dart** - Common text styles
- **app_dimensions.dart** - Common spacing aur radius values

---

## 37. Project Context Summary

Yeh ek Flutter GetX-based chat/social application hai jisme:

- **Custom Components**: Reusable widgets core/widgets/ mein
- **Helper Files**: Utility functions core/utils/ mein
- **Theme System**: Centralized light/dark theme core/theme/ mein
- **API Layer**: Dio-based API service with auth interceptor
- **State Management**: GetX controllers aur reactive variables
- **Modules**: Auth, Home, Chat Room, Calls, Updates, Comments

Project ka goal hai pixel-perfect Figma design implementation with dark/light mode support, clean architecture, aur reusable design system.

---

## 38. One-Line Project Context

This is a Flutter GetX-based pixel-perfect chat/social app using a centralized design system, dark/light themes, Dio API layer, reusable widgets, and modular screens such as Auth, Home, Chat Room, Calls, Updates, and Comments.
