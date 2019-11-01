package com.ebest.dsd;

/**
 * Created by beiyong14 on 2017/12/14.
 */

public class Zebra520Config {
    public final static int PRINT_WIDTH = 800;
    public final static int ACTULA_WIDTH = 760;//对于Zebra520
//    public final static int ACTULA_WIDTH = 520;//对于Zebra510
    public final static int FONT_SIZE = 25;
    public final static int CHAR_SIZE = 13;

    public static int getLineLength(){
//        return ACTULA_WIDTH / CHAR_SIZE;
        return 54;
    }

    public static String getStartCommandByBitmap(int height){
        return String.format("^XA" + "^POI^PW%d^LL%d^LH0,0" + "^XZ" + "\r\n",ACTULA_WIDTH,height);
    }

    public static String getStartCommandByArea(int ll){
        return String.format("^XA" + "^CW1,ANMDJ.TTF^CI28^PW%d^LL%d^LH0,0" + "\r\n",ACTULA_WIDTH,ll);
    }

    public static String getStartCommandByArea2(int ll){
        return  String.format("^XA" + "^POI^LL%d" + "\r\n",ll);
    }

    public static String getEndCommandByArea(){
        return "\r\n" + "^XZ";
    }

    public static String getFormatByLine(){
        return "^FO%d,%d" + "\r\n" + "^A0,N,%d,%d" + "\r\n" + "^FD%s^FS"  + "\r\n";
    }


    public static String getPrintText(int startX,int startY,String text){
        return String.format(getFormatByLine(),startX,startY,FONT_SIZE,FONT_SIZE,text);
    }

    public static int getStartYByLineIndex(int lineIndex){
        return lineIndex * 50;
    }
}
