package com.cloud.util;

import java.io.File;
import java.io.IOException;
import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

public class HDFSTool {

	private static HDFSTool mHdfsTool = null;
	private Configuration conf = null;

	private HDFSTool() {
		conf = new Configuration();
	}

	public synchronized static HDFSTool getInstance() {
		if (mHdfsTool == null) {
			mHdfsTool = new HDFSTool();
		}
		return mHdfsTool;
	}

	public boolean upLoadFile(String path, String localfile) {
		File file = new File(localfile);
		if (!file.isFile()) {
			return false;
		}
		try {
			FileSystem localFS = FileSystem.getLocal(conf);
			FileSystem hadoopFS = FileSystem.get(
					URI.create("hdfs://172.31.34.33:9000/"), conf);

			Path hadPath = new Path(path);
			FSDataOutputStream fsOut = hadoopFS.create(new Path(path + "/"
					+ file.getName()));
			FSDataInputStream fsIn = localFS.open(new Path(localfile));
			byte[] buf = new byte[1024];
			int readbytes = 0;

			while ((readbytes = fsIn.read(buf)) > 0) {
				fsOut.write(buf, 0, readbytes);
			}
			fsIn.close();
			fsOut.close();
			FileStatus[] hadfiles = hadoopFS.listStatus(hadPath);
			for (FileStatus fs : hadfiles) {
				System.out.println(fs.toString());
			}
			return true;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean downloadFile(String hadfile, String localPath) {
		try {
			System.out.println("hadfile:" + hadfile);
			System.out.println("localpath:" + localPath);
			FileSystem localFS = FileSystem.getLocal(conf);
			FileSystem hadoopFS = FileSystem.get(
					URI.create("hdfs://172.31.34.33:9000/"), conf);
			Path hadPath = new Path(hadfile);
			FSDataOutputStream fsOut = localFS.create(new Path(localPath + "/"
					+ hadPath.getName()));
			System.out.println("hadpath.getname:" + hadPath.getName());

			FSDataInputStream fsIn = hadoopFS.open(hadPath);
			byte[] buf = new byte[1024];
			int readbytes = 0;
			while ((readbytes = fsIn.read(buf)) > 0) {
				fsOut.write(buf, 0, readbytes);
			}
			fsIn.close();
			fsOut.close();
			return true;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean delFile(String hadfile) {
		try {
			FileSystem hadoopFS = FileSystem.get(conf);
			Path hadPath = new Path(hadfile);
			Path p = hadPath.getParent();
			boolean rtnval = hadoopFS.delete(hadPath, true);
			FileStatus[] hadfiles = hadoopFS.listStatus(p);
			for (FileStatus fs : hadfiles) {
				System.out.println(fs.toString());
			}
			return rtnval;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

}
