package com.ebest.dsd;

import android.bluetooth.BluetoothDevice;
import android.graphics.Bitmap;
import android.os.Environment;


import com.zebra.sdk.comm.BluetoothConnection;
import com.zebra.sdk.comm.Connection;
import com.zebra.sdk.graphics.internal.ZebraImageAndroid;
import com.zebra.sdk.printer.PrinterLanguage;
import com.zebra.sdk.printer.ZebraPrinter;
import com.zebra.sdk.printer.ZebraPrinterFactory;



/**
 * Created by beiyong14 on 2019/1/25.
 */

public class PrinterExecutorByZebraBitmap{
    private String address;
    private String imgPath;

    public PrinterExecutorByZebraBitmap(String address,String imgPath){
        this.address = address;
        this.imgPath = imgPath;
    }

    public void execute(){
        try {
            new Thread(new Runnable() {
                public void run() {
                    executeReally();
                }
            }).start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void executeReally() {

        try {
            Connection connection = null;
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.ECLAIR) {
                connection = new BluetoothConnection(address);
            }
            connection.open();
            ZebraPrinter printer;

            if (connection.isConnected()) {
                printer = ZebraPrinterFactory.getInstance(connection);

                if (printer != null) {
                    PrinterLanguage pl = printer.getPrinterControlLanguage();
                    if (pl == PrinterLanguage.CPCL) {
                        System.out.println("This product will not work for CPCL printers!");
                    } else {
                        Bitmap bitmap = ImageUtils.getBitmap(imgPath + "/print" + ".png");
                        bitmap = getScaleBitmapByWidth(bitmap,Zebra520Config.ACTULA_WIDTH);
                        connection.write(Zebra520Config.getStartCommandByBitmap(bitmap.getHeight() + 20).getBytes());

                        printer.printImage(new ZebraImageAndroid(bitmap), 0, 0, bitmap.getWidth(), bitmap.getHeight(), false);

                    }
                    connection.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {

        }
    }

    private Bitmap getScaleBitmapByWidth(Bitmap bitmap,int width){
        float scale = (width * 1f)  / bitmap.getWidth();
        return ImageUtils.scale(bitmap,scale,scale);
    }
}
