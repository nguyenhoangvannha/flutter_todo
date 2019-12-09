# flutter_todo
Todo Mobile Tech Challenge

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

# To gererate code
1. flutter packages pub run build_runner clean
2. flutter packages pub run build_runner build watch (--delete-conflicting-outputs)
- flutter packages pub run build_runner build --delete-conflicting-outputs

# Build apk
flutter build apk --split-per-abi