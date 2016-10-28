

## 调度器

* 使用RxJava，你可以使用subscribeOn()指定观察者代码运行的线程，使用observerOn()指定订阅者运行的线程：

```java
myObservableServices.retrieveImage(url)
    .subscribeOn(Schedulers.io())
    .observeOn(AndroidSchedulers.mainThread())
    .subscribe(bitmap -> myImageView.setImageBitmap(bitmap));
```

## 操作符




##### 举个例子


```java


    private void justData() {
        Observable.just( "parameters" ).map( new Func1<String, List<Student>>() {
            @Override
            public List<Student> call(String s) {
                //此处为子线程
                String name = Thread.currentThread().getName().toString();
                showLog( "Observable" + name );
                List<Student> students = getData();
                return students;
            }
        } ).subscribeOn( Schedulers.io() ).observeOn( AndroidSchedulers.mainThread() ).subscribe( new Subscriber<List<Student>>() {

            @Override
            public void onStart() {
                super.onStart();
                String name = Thread.currentThread().getName().toString();
                showLog( "onStart" + name );
                mPb.setVisibility( View.VISIBLE );

            }

            @Override
            public void onCompleted() {
                showMsg( "onCompleted" );
                mPb.setVisibility( View.GONE );

            }

            @Override
            public void onError(Throwable e) {

                showLog( e.getMessage() );
            }

            @Override
            public void onNext(List<Student> students) {
                String name = Thread.currentThread().getName().toString();
                showLog( "Observer" + name );
                mAdapter.addData( students );
            }
        } );
    }

```

