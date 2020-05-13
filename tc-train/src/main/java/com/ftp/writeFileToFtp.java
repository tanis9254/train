package com.ftp;

import org.apache.commons.net.ftp.FTPClient;

import java.io.OutputStreamWriter;
import java.io.PrintWriter;

/**
 * @author: tang.xi
 * @date: 2019/12/23
 * @description:
 */
public class writeFileToFtp {
    public static void main(String[] args) {
        writeFileToFtp("com.txt", "124124");
    }

    public static void writeFileToFtp(String fileName, String content) {
        try {
            FTPClient ftpClient = new FTPClient();
            ftpClient.connect("127.0.0.1", 21);
            ftpClient.login("root", "root");
            boolean hasDir = ftpClient.changeWorkingDirectory("userBehavior");
            if (!hasDir) {
                //创建文件夹
                ftpClient.makeDirectory("test");
                ftpClient.changeWorkingDirectory("test");
            }
            ftpClient.setControlEncoding("utf-8");
            //向指定文件写入内容，如果没有该文件，则先创建文件再写入。写入的方式是追加。
            PrintWriter pw = new PrintWriter(new OutputStreamWriter(ftpClient.appendFileStream(fileName), "utf-8"), true);
            pw.write(content);
            pw.flush();
            pw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}