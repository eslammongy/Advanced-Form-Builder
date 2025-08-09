

https://github.com/user-attachments/assets/20344123-8cd9-40ef-8da2-b797f3aac1d5

# Flutter Form Validation with Riverpod

## Overview
A scalable form validation system using Riverpod that manages multiple form types with independent field states. Each form type maintains its own validation state without cross-contamination.

## Architecture

### Core Concept
Instead of a single shared form state, each form type has its own dedicated state and notifier, ensuring complete independence between forms.

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   SignIn Form   │    │   SignUp Form   │    │   Guest Form    │    │   Admin Form    │
│                 │    │                 │    │                 │    │                 │
│ • userName      │    │ • userName      │    │ • userName      │    │ • userName      │
│ • email         │    │ • email         │    │                 │    │ • userId        │
│                 │    │ • password      │    │                 │    │ • rule          │
│                 │    │ • confirmPass   │    │                 │    │                 │
│                 │    │ • phoneNumber   │    │                 │    │                 │
│                 │    │ • privacyPolicy │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Key Components

#### 1. Form-Specific State Classes
```dart
class SignInFormState {
  final FormField userName;
  final FormField email;
  final bool isFormValid;
  // Only fields needed for SignIn
}

class SignUpFormState {
  final FormField userName;  // Independent from SignIn userName
  final FormField email;     // Independent from SignIn email
  final FormField password;
  // ... other SignUp-specific fields
}
```

#### 2. Dedicated Notifiers
```dart
class SignInFormNotifier extends StateNotifier<SignInFormState> {
  void updateUserName(String value) { /* SignIn-specific logic */ }
  void updateEmail(String value) { /* SignIn-specific logic */ }
}

class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  void updateUserName(String value) { /* SignUp-specific logic */ }
  void updateEmail(String value) { /* SignUp-specific logic */ }
}
```

#### 3. Provider System
```dart
// Individual form providers
final signInFormProvider = StateNotifierProvider<SignInFormNotifier, SignInFormState>
final signUpFormProvider = StateNotifierProvider<SignUpFormNotifier, SignUpFormState>

// Scoped providers that route to correct form based on current type
final scopedUserNameProvider = Provider<FormField>((ref) {
  final formType = ref.watch(currentFormTypeProvider);
  switch (formType) {
    case FormType.signIn: return ref.watch(signInFormProvider).userName;
    case FormType.signUp: return ref.watch(signUpFormProvider).userName;
  }
});
```

## Form Types & Fields

| Form Type | Fields |
|-----------|--------|
| **SignIn** | userName, email |
| **SignUp** | userName, email, password, confirmPassword, phoneNumber, privacyPolicy |
| **Guest** | userName |
| **Admin** | userName, userId, rule |

## Validation Rules

- **Username**: 3-20 chars, alphanumeric + underscore
- **Email**: Standard email format
- **Password**: 8+ chars, uppercase + lowercase + number
- **Phone**: 10+ digits, flexible format
- **User ID**: 5+ characters
- **Rule**: 3+ characters (string value)
- **Privacy Policy**: Must be accepted

## Key Benefits

### 1. **Field Independence**
```dart
// These are completely separate:
signInForm.userName.value = "john_signin"
signUpForm.userName.value = "john_signup" 
guestForm.userName.value = "john_guest"
```

### 2. **Type Safety**
Each form can only access its relevant fields at compile time.

### 3. **Memory Efficiency**
Forms only store the fields they actually use.

### 4. **Scalability**
Adding new form types or fields doesn't affect existing forms.

## Usage

### 1. Setup
```dart
void main() {
  runApp(ProviderScope(child: MyApp()));
}
```

### 2. Switch Form Types
```dart
ref.read(mainFormProvider.notifier).setFormType(FormType.signUp);
```

### 3. Update Fields
```dart
// Updates only the current form's field
ref.read(signUpFormProvider.notifier).updateUserName("newUsername");
```

### 4. Submit Form
```dart
// Validates and submits current form only
await ref.read(signUpFormProvider.notifier).submitForm();
```

## File Structure

```
lib/
├── models/
│   └── form_models.dart           # State classes for each form type
├── validators/
│   └── form_validators.dart       # Validation logic
├── providers/
│   └── form_provider.dart         # Riverpod providers and notifiers
├── widgets/
│   ├── custom_text_field.dart     # Reusable text field widget
│   └── form_widget.dart           # Main form UI
└── main.dart                      # App entry point
```

## Example Flow

1. **User selects SignUp form**
2. **Enters username "john_signup"**
3. **Switches to SignIn form**
4. **Enters username "john_signin"**  
5. **Switches back to SignUp**
6. **Username still shows "john_signup"** ✅

Each form maintains its independent state, preventing data loss and confusion.
