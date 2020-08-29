package com.example.fst_app_flutter;/*
									Dart          Java	                Kotlin	      Obj-C	                                            Swift
									null	      null	                null	      nil (NSNull when nested)	                        nil
									bool	      java.lang.Boolean     Boolean	      NSNumber numberWithBool:	                        NSNumber(value: Bool)
									int	          java.lang.Integer	    Int	          NSNumber numberWithInt:	                        NSNumber(value: Int32)
									int, 64	      java.lang.Long	    Long	      NSNumber numberWithLong:	                        NSNumber(value: Int)
									double	      java.lang.Double	    Double	      NSNumber numberWithDouble:	                    NSNumber(value: Double)
									String	      java.lang.String	    String	      NSString	                                        String
									Uint8List     byte[]	            ByteArray	  FlutterStandardTypedData typedDataWithBytes:	    FlutterStandardTypedData(bytes: Data)
									Int32List     int[]	                IntArray	  FlutterStandardTypedData typedDataWithInt32:	    FlutterStandardTypedData(int32: Data)
									Int64List     long[]	            LongArray	  FlutterStandardTypedData typedDataWithInt64:	    FlutterStandardTypedData(int64: Data)
									Float64List	  double[]	            DoubleArray	  FlutterStandardTypedData typedDataWithFloat64:    FlutterStandardTypedData(float64: Data)
									List	      java.util.ArrayList   List	      NSArray	                                        Array
									Map	          java.util.HashMap	    HashMap	      NSDictionary	                                    Dictionary
									*/

import androidx.annotation.NonNull;

import com.example.fst_app_flutter.contact.NativeContact;

import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

@SuppressWarnings("unchecked")
public class MainActivity extends FlutterActivity {
	private static final String CHANNEL = "com.example.fst_app_flutter/native";

	@Override
	public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
		super.configureFlutterEngine(flutterEngine);
		new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
				.setMethodCallHandler((call, result) -> {
					if ("saveNatively".equals(call.method)) {
						try {
							NativeContact contact = new NativeContact((HashMap<String, Object>) call.arguments);
							contact.saveNatively(this);
						} catch (Exception e) {
							//System.out.println(e.getMessage());
						}
					} else {
						result.notImplemented();
					}
				});
	}
}
