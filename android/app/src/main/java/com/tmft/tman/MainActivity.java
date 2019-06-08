package com.tmft.tman;

import android.content.Context;
import android.database.Cursor;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  DatabaseHelper myDb;
  private static final String CHANNEL = "com.tmft.tman";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    myDb = new DatabaseHelper(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("getTasks")) {
          String tasks = getTasks();
          result.success(tasks);
        } else if (methodCall.method.equals("addTask")) {
          String tName = methodCall.argument("tName");
          String tNote = methodCall.argument("tNote");
          String tDate = methodCall.argument("tDate");
          String tTime = methodCall.argument("tTime");

          String addTaskResult = addTask(tName, tNote, tDate, tTime);
          result.success(addTaskResult);
        }
      }
    });
  }


  String addTask(String tName, String tNote, String tDate, String tTime) {
    try {
      return myDb.insertData(tName, tNote, tDate, tTime);
    } catch (Exception e) {
      return e.toString();
    }
  }


  String getTasks() {
    JSONArray tasksArr = new JSONArray();
    JSONObject tasksObj = new JSONObject();
    try {

      Cursor res = myDb.getAllData();
      if (res.getCount() == 0) {
        return "NoData";
      }

      while (res.moveToNext()) {

        try {

          tasksObj.put("taskName", res.getString(0));
          tasksObj.put("taskNote", res.getString(1));
          tasksObj.put("taskDate", res.getString(2));
          tasksObj.put("taskTime", res.getString(3));
          tasksArr.put(tasksObj);
          tasksObj = new JSONObject();
        } catch (JSONException e) {
          e.printStackTrace();
        }

      }

    } catch (Exception e) {
//      Toast.makeText(this, "This is my Toast message!",
//              Toast.LENGTH_LONG).show();
      Toast.makeText(this, e.toString(),
              Toast.LENGTH_LONG).show();
      return null;
    }
//    Toast.makeText(this, tasksArr.toString(),
//              Toast.LENGTH_LONG).show();
    return tasksArr.toString();
  }
}
