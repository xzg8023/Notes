

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
##相关的示例代码

+ MainActivity.java
```java
package com.rxjava.demo;

import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.os.StrictMode;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;

import rx.Observable;
import rx.Observer;
import rx.Subscriber;
import rx.android.schedulers.AndroidSchedulers;
import rx.functions.Action0;
import rx.functions.Action1;
import rx.functions.Func1;
import rx.functions.Func2;
import rx.observables.GroupedObservable;
import rx.observables.SyncOnSubscribe;
import rx.schedulers.Schedulers;
import rx.subjects.PublishSubject;

public class MainActivity extends AppCompatActivity {

    private String tag = "xzg";

    private Context mContext;
    private ImageView mIv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate( savedInstanceState );
        setContentView( R.layout.activity_main );
        mContext = this;


        mIv = (ImageView) findViewById( R.id.iv );
    }

    public void bt1(View view) {
//        createObservable();
//        observableFrom();
//        distinctUntilChange();
//        elementAt();
        getObservable();
    }


    public void bt2(View view) {
//        observableJust();
//        take();
//        distinct();
//        sample();
    }


    public void bt3(View view) {
//        publishSubject();
//        takeLast();
//        distinct2();
        groupBy();
    }

    public void bt4(View view) {
//        range();
//        timer();
//        scan();
        merge();
    }


    public void bt5(View view) {

        startActivity( new Intent( MainActivity.this, ListActivity.class ) );
    }

    Observer<String> stringObserver = new Observer<String>() {
        @Override
        public void onCompleted() {
            showLog( "-----onCompleted-----" + "onCompleted" );
        }

        @Override
        public void onError(Throwable e) {
            showLog( "-----onError-----" + e.getMessage().toString() );
        }

        @Override
        public void onNext(String s) {
            showLog( "-----onNext-----" + s );
        }
    };


    //创建一个Observable
    private void createObservable() {

        final Observable<String> stringObservable = Observable.create( new Observable.OnSubscribe<String>() {
            @Override
            public void call(Subscriber<? super String> subscriber) {

                for (int i = 0; i < 5; i++) {
                    stringObserver.onNext( "test" + i );
                }
                stringObserver.onCompleted();
            }
        } );
        stringObservable.subscribe( stringObserver );
    }


    /**
     *
     */
    private void observableFrom() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            lists.add( "from" + i );
        }

        Observable<String> listObservable = Observable.from( lists );
        listObservable.subscribe( stringObserver );

    }


    private void take() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            lists.add( "take" + i );
        }
        Observable.from( lists ).take( 3 ).subscribe( stringObserver );
    }

    private void takeLast() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            lists.add( "take" + i );
        }
        Observable.from( lists ).takeLast( 3 ).subscribe( stringObserver );
    }

    private void distinctUntilChange() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            lists.add( "take" + i );
            lists.add( "take" + i );
        }
        Observable.from( lists ).distinctUntilChanged().subscribe( stringObserver );
    }

    private void distinct() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            lists.add( "take" + i );
        }
        Observable.from( lists ).repeat( 2 ).subscribe( stringObserver );
    }

    private void distinct2() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            lists.add( "take" + i );
        }
        Observable.from( lists ).repeat( 2 ).distinct().subscribe( stringObserver );
    }

    private void elementAt() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            lists.add( "take" + i );
        }
        Observable.from( lists ).elementAt( 2 ).subscribe( stringObserver );
    }

    private void sample() {
        List<String> lists = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            lists.add( "take" + i );
        }
        Observable.from( lists ).sample( 1, TimeUnit.MICROSECONDS ).subscribe( stringObserver );
    }

    private void observableJust() {
        Observable<String> justObservable = Observable.just( getString() );
        justObservable.subscribe( stringObserver );

    }


    private void scan() {
        Observable.just( 1, 2, 3, 4, 5 ).scan( new Func2<Integer, Integer, Integer>() {
            @Override
            public Integer call(Integer integer, Integer integer2) {
                return integer + integer2;
            }
        } ).distinct().subscribe( new Subscriber<Integer>() {
            @Override
            public void onCompleted() {
                showLog( "onCompleted" );
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(Integer integer) {
                showLog( "-----onNext-----" + integer );
            }
        } );
    }

    private void groupBy() {
        List<Integer> lists = new ArrayList<>();
        lists.add( 6 );
        lists.add( 1 );
        lists.add( 2 );
        lists.add( 6 );
        lists.add( 9 );
        lists.add( 3 );
        lists.add( 4 );
        Observable<GroupedObservable<String, Integer>> groupedObservableObservable = Observable.from( lists ).groupBy( new Func1<Integer, String>() {
            @Override
            public String call(Integer integer) {
                return integer + "";
            }
        } );

        Observable.concat( groupedObservableObservable )/*.scan( new Func2<Integer, Integer, Integer>() {
            @Override
            public Integer call(Integer integer, Integer integer2) {
                if (integer > integer2){
                    return  integer2;
                }
                return integer;
            }
        } )*/.subscribe( new Subscriber<Integer>() {
            @Override
            public void onCompleted() {
                showLog( "onCompleted" );
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(Integer integer) {
                showLog( "-----onNext-----" + integer );
            }
        } );
    }

    private void merge() {
        List<Integer> lists1 = new ArrayList<>();
        lists1.add( 6 );
        lists1.add( 1 );
        lists1.add( 2 );
        lists1.add( 6 );
        lists1.add( 9 );
        lists1.add( 3 );
        lists1.add( 4 );
        List<Integer> lists = new ArrayList<>();
        for (int i = 10; i < 20; i++) {
            lists.add( i );
        }
        Observable<Integer> observable1 = Observable.from( lists1 );
        Observable<Integer> observable2 = Observable.from( lists );

        Observable.merge( observable1, observable2 ).subscribe( new Subscriber<Integer>() {
            @Override
            public void onCompleted() {

                showLog( "onCompleted" );
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(Integer integer) {
                showLog( "-----------onNext--------------" + integer );
            }
        } );
    }

    private String getString() {
        return "Hello world !";
    }

    private void publishSubject() {

        PublishSubject<String> publishSubject = PublishSubject.create();

        publishSubject.subscribe( new Subscriber<String>() {
            @Override
            public void onCompleted() {
                showLog( "-----onCompleted-----" + "onCompleted" );
            }

            @Override
            public void onError(Throwable e) {
                showLog( "-----onError-----" + e.getMessage().toString() );
            }

            @Override
            public void onNext(String s) {
                showLog( "-----onNext-----" + s );
            }
        } );
//        try {
//            Thread.sleep( 2000 );
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
        publishSubject.onNext( "hello world !!!" );
    }

    private void defer() {

//        Observable<Object> observable = Observable.create();
//        Observable.defer(observable );
    }

    private void range() {
        Observable.range( 10, 3 ).subscribe( new Observer<Integer>() {
            @Override
            public void onCompleted() {

                showMsg( "onCompleted" );
            }

            @Override
            public void onError(Throwable e) {
                showMsg( e.getMessage() );
            }

            @Override
            public void onNext(Integer integer) {
                showMsg( "" + integer );
            }
        } );
    }


    private void timer() {
        Observable.timer( 3, TimeUnit.SECONDS ).subscribeOn( Schedulers.io() ).observeOn( AndroidSchedulers.mainThread() ).subscribe( new Observer<Long>() {
            @Override
            public void onCompleted() {

            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(Long aLong) {
                showLog( "aLong" );
            }
        } );
    }

    private void getObservable() {

        Subscriber<String> subscriber = new Subscriber<String>() {
            @Override
            public void onCompleted() {

                showLog( "---------------onCompleted------------" );
            }

            @Override
            public void onError(Throwable e) {

                showLog( "---------------onError-----------" + e.getMessage() );
            }

            @Override
            public void onNext(String s) {
                showLog( "onNext-----当前线程::"+Thread.currentThread().getName().toString() );
                showLog( "----------------onNext------------" + s );
            }
        };

        Observable<String> observable = Observable.create( new Observable.OnSubscribe<String>() {
            @Override
            public void call(Subscriber<? super String> subscriber) {
                List<String> list = new ArrayList();

                for (int i = 0; i < 10; i++) {
                    list.add( "item" + i );
                }

                for (String item : list) {

                    try {
                        Thread.sleep( 1000 );
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    showLog( "observable------当前线程::"+Thread.currentThread().getName().toString() );
                    subscriber.onNext( item );


                }

                subscriber.onCompleted();

            }
        } );
        observable.subscribeOn( Schedulers.io() ).observeOn( AndroidSchedulers.mainThread() ).subscribe( subscriber );

    }


    public void showMsg(String msg) {
        Toast.makeText( mContext, msg, Toast.LENGTH_SHORT ).show();
    }

    private void showLog(String msg) {
        Log.e( tag, msg );
    }

}

```
