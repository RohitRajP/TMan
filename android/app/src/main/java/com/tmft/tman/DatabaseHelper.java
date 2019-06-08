package com.tmft.tman;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class DatabaseHelper extends SQLiteOpenHelper {
    public static final String DATABASE_NAME = "TMan2.db";
    public static final String TABLE_NAME = "tasks2";
    public static final String columnTName = "taskName";
    public static final String columnTNote = "taskNote";
    public static final String columnTDate = "taskDate";
    public static final String columnTTime = "taskTime";

    public DatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        try {
            db.execSQL("create table " + TABLE_NAME + " (" + columnTName + " VARCHAR(300) PRIMARY KEY," + columnTNote + " " +
                    "TEXT," + columnTDate + " TEXT," + columnTTime + " TEXT)");
        } catch (Exception e) {
            Log.d("onCreateDB", "OnCreateDB Error");
        }
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        try {
            db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
            onCreate(db);
        } catch (Exception e) {
            Log.d("OnUpgradeDB", "OnUpgradeDB Error");
        }


    }

    public String insertData(String TName, String TNote, String TDate, String TTime) {

        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(columnTName, TName);
        contentValues.put(columnTNote, TNote);
        contentValues.put(columnTDate, TDate);
        contentValues.put(columnTTime, TTime);
        long result;
        try {
            result = db.insert(TABLE_NAME, null, contentValues);
        } catch (Exception e) {
            return "Error in Database insertData()";
        }
        if (result == -1)
            return "Could not insert";
        else {
            return "Inserted";
        }


    }

    public Cursor getAllData() {
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor res = db.rawQuery("select * from " + TABLE_NAME, null);
        return res;
    }

    public boolean updateData(String TName, String TNote, String TDate, String TTime) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(columnTName, TName);
        contentValues.put(columnTNote, TNote);
        contentValues.put(columnTDate, TDate);
        contentValues.put(columnTTime, TTime);
        db.update(TABLE_NAME, contentValues, "taskName= ?", new String[]{TName});
        return true;
    }

    public Integer deleteData(String id) {
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete(TABLE_NAME, "ID = ?", new String[]{id});
    }
}