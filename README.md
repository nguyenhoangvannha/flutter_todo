# flutter_todo
Todo Mobile Tech Challenge

# Download apk
- __[arm64-v8a](https://github.com/nguyenhoangvannha/flutter_todo/releases/download/v1.0/app-arm64-v8a-release.apk)__
<br>
- __[armeabi-v7a](https://github.com/nguyenhoangvannha/flutter_todo/releases/download/v1.0/app-armeabi-v7a-release.apk)__

# Requirement:
## Writing a TODO application include 3 screens:
- All: Showing both complete and incomplete todo.
- Complete: Showing complete todo.
- Incomplete: Showing incomplete todo.
- And a bottom navigation to switch between above screens.
## Business logic:
- Have a checkbox on each todo, if checked is complete, not is
incomplete.
- When interacting check and uncheck have to update UI.
## Technical:
- You can use any architecture that you want.
- Should have unit test.
- Using appropriate data structures

# Build apk
- Clone project

        git clone https://github.com/nguyenhoangvannha/flutter_todo.git

- Open terminal and run

        flutter pub get 
        
- To gererate code run

        flutter packages pub run build_runner build --delete-conflicting-outputs

- Build release run

        flutter build apk --split-per-abi

- Your apk location

        */flutter_todo/build/app/outputs/apk/release
# Dependencies
  ## internationalization
  - flutter_localizations:

  ## state management
  - flutter_bloc: ^2.1.1

  ## local database
  - moor_flutter: ^2.0.0
  <br>
  - shared_preferences: ^0.5.4+8

  ## di
  - injector: ^1.0.8

  ## ui
  - shimmer: ^1.0.1
  <br>
  - flutter_form_builder: ^3.7.1

  ## utils
  - equatable: ^1.0.1
  <br>
  - intl: ^0.15.8

  ## test
- flutter_test:
-  mockito: ^4.1.1
- bloc_test: ^2.2.2
  ## source gen
 - build_runner:
 - moor_generator: ^2.1.1