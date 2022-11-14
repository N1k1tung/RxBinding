# RxBinding

Streamlines bindings between view and viewModel, makes them more concise and readable

**Before**

```swift
    loginButton.rx.tap
        .bind(to: vm.loginTapped)
        .disposed(by: disposeBag)
    emailButton.rx.tap
        .sink(vm.emailTapped)
        .disposed(by: disposeBag)    
    tableView.modelSelected
        .subscribe { [weak self] _ in self?.tableView.reloadData() }
        .disposed(by: disposeBag)
    someButton.rx.tap
        .subscribe(vm.someSubject)
        .disposed(by: disposeBag)
 }
```


**After**

```swift
 bind {
    loginButton.rx.tap ~> vm.loginTapped
    emailButton.rx.tap ~> vm.emailTapped
    tableView.modelSelected ~> { [weak self] _ in self?.tableView.reloadData() }
    someButton.rx.tap ~> vm.someSubject
 }
```
