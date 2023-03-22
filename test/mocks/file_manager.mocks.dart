// Mocks generated by Mockito 5.3.2 from annotations
// in financial_tracker/test/mocks/generate.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:io' as _i4;

import 'package:financial_tracker/Applications/utils/file_manager.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FileManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockFileManager extends _i1.Mock implements _i2.FileManager {
  MockFileManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> addFile(_i4.File? file) => (super.noSuchMethod(
        Invocation.method(
          #addFile,
          [file],
        ),
        returnValue: _i3.Future<String>.value(''),
      ) as _i3.Future<String>);
  @override
  _i3.Future<void> deleteFile(String? path) => (super.noSuchMethod(
        Invocation.method(
          #deleteFile,
          [path],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
