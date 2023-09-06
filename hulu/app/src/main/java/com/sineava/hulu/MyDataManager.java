package com.sineava.hulu;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

public class MyDataManager {

    private static MyDataManager instance;
    private SQLiteDatabase db;

    private MyDataManager(Context context) {
        // 实例化MyDatabaseHelper对象
        MyDatabaseHelper dbHelper = new MyDatabaseHelper(context);
        // 获取可写数据库对象
        db = dbHelper.getWritableDatabase();
    }

    public static synchronized MyDataManager getInstance(Context context) {
        if (instance == null) {
            instance = new MyDataManager(context);
        }
        return instance;
    }

    // 插入一条数据
    public void insertData(String tableName, ContentValues values) {
        db.insert(tableName, null, values);
    }

    // 查询所有数据
    public Cursor queryAllData(String tableName) {
        return db.query(tableName,
                null, null, null, null, null, null);
    }
}