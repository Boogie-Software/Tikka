import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tikka/presentation/controller.dart';
import 'package:tikka/presentation/presenter.dart';
import 'package:tikka/presentation/view_event.dart';
import 'package:tikka/presentation/view_state.dart';
import 'package:tikka/ui/page/tikka_page.dart';
import 'package:tikka/ui/page/tikka_page_state.dart';


class MockController extends Mock implements Controller {
  @override
  MockPresenter get presenter => MockPresenter();

  final CallWatcher onViewInitCalls = CallWatcher();
  final CallWatcher onViewDisposeCalls = CallWatcher();
  final CallWatcher onViewActivateCalls = CallWatcher();
  final CallWatcher onViewDeactivateCalls = CallWatcher();
  final CallWatcher onViewReassembleCalls = CallWatcher();
  final CallWatcher onViewUpdateCalls = CallWatcher();

  @override
  void onViewInit() { onViewInitCalls.call(); }
  
  @override
  void onViewDispose() { onViewDisposeCalls.call(); }
  
  @override
  void onViewActivate() { onViewActivateCalls.call(); }
  
  @override
  void onViewDeactivate() { onViewDeactivateCalls.call(); }
  
  @override
  void onViewReassemble() { onViewReassembleCalls.call(); }
  
  @override
  void onViewUpdate() { onViewUpdateCalls.call(); }
}

class MockPresenter extends Mock implements Presenter<ViewEvent, ViewState> {
  @override
  MockViewState viewState = MockViewState();

  @override
  set viewStateObserver(observer) {}
}

class MockViewState extends Mock implements ViewState {}

// ignore: must_be_immutable
class MockTikkaPage extends Mock implements TikkaPage<MockController> {

  final TestTikkaPageState state = TestTikkaPageState();

  @override
  MockController controller = MockController();

  @override
  StatefulElement createElement() => StatefulElement(this);
  
  @override
  // ignore: no_logic_in_create_state
  TestTikkaPageState createState() => state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => super.toString();
}

class TestTikkaPageState extends TikkaPageState<MockController, MockViewState, MockTikkaPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("foo");
  }
}

void main() {
  late MockTikkaPage page;
  late TestTikkaPageState state;
  late MockController controller;

  setUp(() {
    page = MockTikkaPage();
    page.createElement();
    controller = page.controller;
    state = page.createState();
    state.controller = controller;
    state.viewState = controller.presenter.viewState;
    state.initState();
  });

  test('initState initializes correctly', () {
    expect(controller.onViewInitCalls.callCount, 1);
    expect(state.viewState, isA<MockViewState>());
  });

  test('activate calls onViewActivate', () {
    state.activate();
    expect(controller.onViewActivateCalls.callCount, 1);
  });

  test('deactivate calls onViewDeactivate', () {
    state.deactivate();
    expect(controller.onViewDeactivateCalls.callCount, 1);
  });

  test('reassemble calls onViewReassemble', () {
    state.reassemble();
    expect(controller.onViewReassembleCalls.callCount, 1);
  });


  test('setState calls onViewUpdate', () {
    state.setState(() {});
    expect(controller.onViewUpdateCalls.callCount, 1);
  });

  test('onViewStateChanged updates viewState', () {
    final newViewState = MockViewState();
    state.onViewStateChanged(newViewState);
    expect(state.viewState, newViewState);
  });

}

class CallWatcher {
  int _callCount = 0;

  int get callCount => _callCount;

  bool called(int count) => callCount == count;

  void call() {
    _callCount++;
  }
}
