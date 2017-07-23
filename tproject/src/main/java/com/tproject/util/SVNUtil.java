package com.tproject.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.tmatesoft.svn.core.SVNCommitInfo;
import org.tmatesoft.svn.core.SVNDepth;
import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNErrorCode;
import org.tmatesoft.svn.core.SVNErrorMessage;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLock;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;
import org.tmatesoft.svn.core.SVNNodeKind;
import org.tmatesoft.svn.core.SVNProperties;
import org.tmatesoft.svn.core.SVNProperty;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.io.ISVNEditor;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.io.diff.SVNDeltaGenerator;
import org.tmatesoft.svn.core.wc.SVNClientManager;
import org.tmatesoft.svn.core.wc.SVNCommitClient;
import org.tmatesoft.svn.core.wc.SVNDiffClient;
import org.tmatesoft.svn.core.wc.SVNLogClient;
import org.tmatesoft.svn.core.wc.SVNRevision;
import org.tmatesoft.svn.core.wc.SVNStatus;
import org.tmatesoft.svn.core.wc.SVNStatusClient;
import org.tmatesoft.svn.core.wc.SVNUpdateClient;
import org.tmatesoft.svn.core.wc.SVNWCClient;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

@Component
public class SVNUtil {
	@Autowired
	StatusHandler statushandler;
	@Autowired
	AnnotationHandler annotationhandler;
	
	private static int totalrepotreecount = 0; //�옱洹��샇異쒖씠�씪 �젙�쟻 硫ㅻ쾭蹂��닔濡� �븘�슂//
	private static List<Object>repotreelist_name;
	private static List<Object>repotreelist_author;
	private static List<Object>repotreelist_revesion;
	private static List<Object>repotreelist_date;
	private static List<Object>repotreelist_lock;
	private static List<Object>repotreelist_kind;
	private static List<Object>repotreelist_commitmessage;
	private static List<Object>repotreelist_filepath;
	
	public Map<String, Object> doMakeRepo(String repourl){
		Map<String, Object> makerepomap = new HashMap<String,Object>();
		
		try {
			SVNURL tgtURL = SVNRepositoryFactory.createLocalRepository( new File( repourl ), true , false );
			
			System.out.println("repo URL: " + tgtURL);
			
			makerepomap.put("resultVal", "1");
			makerepomap.put("repopath", ""+tgtURL);
			
			return makerepomap;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			makerepomap.put("resultVal", "0");
		}
		
		return makerepomap;
	}
	
	public Map<String, Object> doPrintRepo(String repourl, String userid, String userpassword){
		Map<String, Object> repoinfomap = new HashMap<String,Object>();
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create( SVNURL.parseURIEncoded(repourl));
			
			//인증정보를 설정//
			ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(userid, userpassword);
	        repository.setAuthenticationManager(authManager);
	        
	        System.out.println("Auth Check Success...");
			
			String repoUUID = repository.getRepositoryUUID(true).toString();
			String reporevesion = ""+repository.getLatestRevision();
			String repoRoot = repository.getRepositoryRoot(true).toString();
			String repoURL = repository.getLocation().toString();
			
			repoinfomap.put("repouuid", repoUUID);
			repoinfomap.put("reporevesion", reporevesion);
			repoinfomap.put("reporoot", repoRoot);
			repoinfomap.put("repolocation", repoURL);
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return repoinfomap;
	}
	
	public Map<String, Object> doPrintRepoLog(String repourl, String userid, String userpassword){
		SVNRepository repository = null;
		Collection logEntries = null;
		
		//媛� 濡쒓렇�뿉�꽌 �븘�슂�븳 �뜲�씠�꽣瑜� ���옣�븷 �닔 �엳�뒗 �옄猷뚭뎄議� �꽑�뼵//
		List<Object>revesionlist = new ArrayList<Object>();
		List<Object>authorlist = new ArrayList<Object>();
		List<Object>datelist = new ArrayList<Object>();
		List<Object>logmessagelist = new ArrayList<Object>();
		List<Object>changepathlist = new ArrayList<Object>();
		
		//醫낇빀�젙蹂대�� 媛�吏� 由ъ뒪�듃//
		Map<String, Object>loglist = new HashMap<String, Object>();
		
		long startRevision = 0;
		long endRevision = -1; //HEAD (the latest) revision
		
		int logcount = 0; //key濡� �솢�슜//
		
		StringBuffer str_paths_buffer = new StringBuffer();
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			//인증정보를 설정//
			ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(userid, userpassword);
	        repository.setAuthenticationManager(authManager);
	       
			logEntries = repository.log(new String[] { "" }, null, startRevision, endRevision, true, true);

			for (Iterator entries = logEntries.iterator(); entries.hasNext();) {
				SVNLogEntry logEntry = (SVNLogEntry) entries.next();
	
				revesionlist.add(logEntry.getRevision());
				authorlist.add(logEntry.getAuthor());
				datelist.add(logEntry.getDate().toString());
				logmessagelist.add(logEntry.getMessage());

				if (logEntry.getChangedPaths().size() > 0){
					Set changedPathsSet = logEntry.getChangedPaths().keySet();
					for (Iterator changedPaths = changedPathsSet.iterator(); changedPaths.hasNext();) {
						SVNLogEntryPath entryPath = (SVNLogEntryPath) logEntry.getChangedPaths().get(changedPaths.next());

						str_paths_buffer.append(entryPath.getType());
						str_paths_buffer.append(" ");
						str_paths_buffer.append(entryPath.getPath());
						str_paths_buffer.append(" ");
						str_paths_buffer.append(" ");
						str_paths_buffer.append((entryPath.getCopyPath() != null)
								? " (from " + entryPath.getCopyPath() + " revision " + entryPath.getCopyRevision() + ")"
								: "");
						str_paths_buffer.append("\n");
					}

					changepathlist.add(str_paths_buffer.toString());

					str_paths_buffer.setLength(0); // 珥덇린�솕//
				}
				
				logcount++;
			}
			
			loglist.put("revesionlist", revesionlist);
			loglist.put("authorlist", authorlist);
			loglist.put("datelist", datelist);
			loglist.put("logmessagelist", logmessagelist);
			loglist.put("changepathlist", changepathlist);
			loglist.put("count", ""+logcount);
			
			return loglist;
		}
		catch (SVNException e) {
			e.printStackTrace();
		}
		
		return loglist;
	}
	
	public Map<String, Object> doPrintRepotree(String repourl, String userid, String userpassword){
		Map<String, Object>repotreelistinfo = new HashMap<String, Object>();
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			//인증정보를 설정//
			ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(userid, userpassword);
	        repository.setAuthenticationManager(authManager);
			
			SVNNodeKind nodeKind = repository.checkPath("", -1);
			
			if (nodeKind == SVNNodeKind.NONE) {
				System.err.println("There is no entry at '" + repourl + "'.");
			} else if (nodeKind == SVNNodeKind.FILE) {
				System.err.println("The entry at '" + repourl + "' is a file while a directory was expected.");
			}
			
			repotreelist_name = new ArrayList<Object>();
			repotreelist_author = new ArrayList<Object>();
			repotreelist_revesion = new ArrayList<Object>();
			repotreelist_date = new ArrayList<Object>();
			repotreelist_lock = new ArrayList<Object>();
			repotreelist_kind = new ArrayList<Object>();
			repotreelist_commitmessage = new ArrayList<Object>();
			repotreelist_filepath = new ArrayList<Object>();
			
			
			listEntries(repository, ""); //由ъ뒪�듃瑜� �젙蹂대�� 異붽�//
			
			repotreelistinfo.put("listcount", totalrepotreecount);
			repotreelistinfo.put("repotreelistname", repotreelist_name);
			repotreelistinfo.put("repotreelistauthor", repotreelist_author);
			repotreelistinfo.put("repotreelistrevesion", repotreelist_revesion);
			repotreelistinfo.put("repotreelistdate", repotreelist_date);
			repotreelistinfo.put("repotreelistlock", repotreelist_lock);
			repotreelistinfo.put("repokind", repotreelist_kind);
			repotreelistinfo.put("repocommitmsg", repotreelist_commitmessage);
			repotreelistinfo.put("repofilepath", repotreelist_filepath);
			
			totalrepotreecount = 0; //珥덇린�솕//
		} catch (SVNException e) {
			e.printStackTrace();
		}
		
		return repotreelistinfo;
	}
	
	public static void listEntries(SVNRepository repository, String path) throws SVNException {
        Collection entries = repository.getDir(path, -1, null, (Collection) null);
        Iterator iterator = entries.iterator();
        
        int repptreecount = 0;
        
        while (iterator.hasNext()) {
            SVNDirEntry entry = (SVNDirEntry) iterator.next();
            
            repotreelist_name.add(entry.getName());
            if(entry.getAuthor() != null){
            	repotreelist_author.add(entry.getAuthor());
            }else{
            	repotreelist_author.add("not author");
            }
            repotreelist_revesion.add(entry.getRevision());
            repotreelist_date.add(entry.getDate().toString());
            if(entry.getLock() == null){
            	repotreelist_lock.add("unlock");
            }else{
            	repotreelist_lock.add(entry.getLock());
            }
            
            repotreelist_kind.add(entry.getKind().toString());
            repotreelist_commitmessage.add(entry.getCommitMessage());
            repotreelist_filepath.add(entry.getRelativePath().toString());
        
            repptreecount++;
            
            //재귀적으로 호출 시 하위구조의 정보까지 출력된다.//
            /*if (entry.getKind() == SVNNodeKind.DIR) {
            	//���옣�냼媛� �뵒�젆�꽣由ъ씠硫� Depth�븯�굹瑜� �뜑 �뱾�뼱媛��빞吏� �뙆�씪�씠 �엳湲곗뿉 listEntries瑜� �옱洹��샇異쒗븳�떎.//
                listEntries(repository, (path.equals("")) ? entry.getName() : path + "/" + entry.getName());
            }*/
        }
        
        totalrepotreecount += repptreecount;
    }
	
	public Map<String,Object> doPrintFilecontent(String repourl, String userid, String userpassword, String filename, String filepath){
		Map<String, Object>filecontentinfo = new HashMap<String, Object>();
		String filecontent = "";
		
		System.out.println("file content view");
		
		System.out.println("repo url: " + repourl);
		System.out.println("file name: " + filename);
		System.out.println("file path: " + filepath);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			//인증정보를 설정//
			ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(userid, userpassword);
			repository.setAuthenticationManager(authManager);
			
			SVNNodeKind nodeKind = repository.checkPath(filename, -1);

			System.out.println("repo check ok...");
			System.out.println("nodeKind: " + nodeKind);
			if (nodeKind == SVNNodeKind.NONE || nodeKind == SVNNodeKind.FILE) {
				filecontentinfo.put("type", "file");
			
				SVNProperties fileProperties = new SVNProperties();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
				repository.getFile(filepath, -1, fileProperties, baos);
				
				System.out.println("file view ok...");
				
				String mimeType = fileProperties.getStringValue(SVNProperty.MIME_TYPE);
				boolean isTextType = SVNProperty.isTextMimeType(mimeType);

				Iterator iterator = fileProperties.nameSet().iterator();
				
				while (iterator.hasNext()) {
					String propertyName = (String) iterator.next();
					String propertyValue = fileProperties.getStringValue(propertyName);
					System.out.println("File property: " + propertyName + "=" + propertyValue);
				}

				if (isTextType) {
					System.out.println("File contents:");
					filecontent = baos.toString();
					filecontentinfo.put("content", filecontent);
					System.out.println(filecontent);
				} else {
					System.out.println("Not a text file.");
				}
			} else if (nodeKind == SVNNodeKind.DIR) {
				filecontentinfo.put("type", "directory");
			}
			
			
		} catch (SVNException e) {
			e.printStackTrace();
		}
		
		System.out.println("-----------------------------------------------");
		
		return filecontentinfo;
	}
	
	public Map<String, Object> docommitaddfile(String repourl, String commitpath, String commitlog, String commitfilename, String commitfilecontent, String userid, String userpassword){
		Map<String, Object>resultcommit = new HashMap<String, Object>();
		
		System.out.println("file commit");
		
		System.out.println("repo url: " + repourl);
		System.out.println("commit path: " + commitpath);
		System.out.println("commit log: " + commitlog);
		System.out.println("commit filename: " + commitfilename);
		System.out.println("commit filecontent: " + commitfilecontent);
		System.out.println("repo userid: " + userid);
		System.out.println("repo password: " + userpassword);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			//인증정보를 확인
			//인증정보를 설정//
			ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(userid, userpassword);
			repository.setAuthenticationManager(authManager);
			
			byte[] contents = commitfilecontent.getBytes();
			
			SVNNodeKind nodeKind = repository.checkPath("", -1);

	        if (nodeKind == SVNNodeKind.NONE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "No entry at URL ''{0}''", repourl);
	            throw new SVNException(err);
	        } else if (nodeKind == SVNNodeKind.FILE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "Entry at URL ''{0}'' is a file while directory was expected", repourl);
	            throw new SVNException(err);
	        }
	        
	        long latestRevision = repository.getLatestRevision();
	        System.out.println("Repository latest revision (before committing): " + latestRevision);
	        
	        ISVNEditor editor = repository.getCommitEditor(commitlog, null);
	        
	        SVNCommitInfo commitInfo = addFile(editor, commitpath, commitpath+'/'+commitfilename, contents);
	        System.out.println("The directory was added: " + commitInfo);
	        
	        if(commitInfo != null){
	        	resultcommit.put("resultval", "1");
	        }else if(commitInfo == null){
	        	resultcommit.put("resultval", "0");
	        }
	        
	        return resultcommit;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultcommit.put("resultval", "0");
		}
		
		return resultcommit;
	}
	
	public Map<String, Object> docommitdir(String repourl, String commitpath, String commitlog, String commitfilename, String commitfilecontent, String comitdirname){
		Map<String, Object>resultcommit = new HashMap<String, Object>();
		
		System.out.println("file commit");
		
		System.out.println("repo url: " + repourl);
		System.out.println("commit path: " + commitpath);
		System.out.println("commit log: " + commitlog);
		System.out.println("commit filename: " + commitfilename);
		System.out.println("commit filecontent: " + commitfilecontent);
		System.out.println("commit dirname: " + comitdirname);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			byte[] contents = commitfilecontent.getBytes();
			
			SVNNodeKind nodeKind = repository.checkPath("", -1);

	        if (nodeKind == SVNNodeKind.NONE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "No entry at URL ''{0}''", repourl);
	            throw new SVNException(err);
	        } else if (nodeKind == SVNNodeKind.FILE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "Entry at URL ''{0}'' is a file while directory was expected", repourl);
	            throw new SVNException(err);
	        }
	        
	        long latestRevision = repository.getLatestRevision();
	        System.out.println("Repository latest revision (before committing): " + latestRevision);
	        
	        ISVNEditor editor = repository.getCommitEditor(commitlog, null);
	        
	        SVNCommitInfo commitInfo = adddir(editor, commitpath+'/'+comitdirname, commitpath+'/'+comitdirname+'/'+commitfilename, contents);
	        System.out.println("The directory was added: " + commitInfo);
	        
	        if(commitInfo != null){
	        	resultcommit.put("resultval", "1");
	        }else if(commitInfo == null){
	        	resultcommit.put("resultval", "0");
	        }
	        
	        return resultcommit;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultcommit.put("resultval", "0");
		}
		
		return resultcommit;
	}
	
	private static SVNCommitInfo addFile(ISVNEditor editor, String dirPath, String filePath, byte[] data) throws SVNException {    
        editor.openRoot(-1);
        editor.openDir(dirPath, -1);
        editor.addFile(filePath, null, -1);
        editor.applyTextDelta(filePath, null);
        SVNDeltaGenerator deltaGenerator = new SVNDeltaGenerator();
        String checksum = deltaGenerator.sendDelta(filePath, new ByteArrayInputStream(data), editor, true);

        editor.closeFile(filePath, checksum);
        editor.closeDir();
        editor.closeDir();
       
        return editor.closeEdit();
    }
	
	private static SVNCommitInfo adddir(ISVNEditor editor, String dirPath, String filePath, byte[] data) throws SVNException {    
        editor.openRoot(-1);
        editor.addDir(dirPath, null, -1);
        editor.addFile(filePath, null, -1);
        editor.applyTextDelta(filePath, null);
        SVNDeltaGenerator deltaGenerator = new SVNDeltaGenerator();
        String checksum = deltaGenerator.sendDelta(filePath, new ByteArrayInputStream(data), editor, true);

        editor.closeFile(filePath, checksum);
        editor.closeDir();
        editor.closeDir();
       
        return editor.closeEdit();
    }
	
	public Map<String, Object> docommitmodify(String repourl, String commitpath, String commitlog, String commitfilename, String originalcontent, String updatecontent){
		Map<String, Object>resultcommit = new HashMap<String, Object>();
		
		System.out.println("file commit");
		
		System.out.println("repo url: " + repourl);
		System.out.println("commit path: " + commitpath);
		System.out.println("commit log: " + commitlog);
		System.out.println("commit filename: " + commitfilename);
		System.out.println("commit filecontent: " + originalcontent);
		System.out.println("update content:" + updatecontent);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			byte[] oldcontents = originalcontent.getBytes();
			byte[] updatecontents = updatecontent.getBytes();
			
			SVNNodeKind nodeKind = repository.checkPath("", -1);

	        if (nodeKind == SVNNodeKind.NONE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "No entry at URL ''{0}''", repourl);
	            throw new SVNException(err);
	        } else if (nodeKind == SVNNodeKind.FILE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "Entry at URL ''{0}'' is a file while directory was expected", repourl);
	            throw new SVNException(err);
	        }
	        
	        long latestRevision = repository.getLatestRevision();
	        System.out.println("Repository latest revision (before committing): " + latestRevision);
	        
	        ISVNEditor editor = repository.getCommitEditor(commitlog, null);
	        
	        SVNCommitInfo commitInfo = modifyFile(editor, commitpath, commitpath+'/'+commitfilename, oldcontents, updatecontents);
	        System.out.println("The file was changed: " + commitInfo);
	        
	        if(commitInfo != null){
	        	resultcommit.put("resultval", "1");
	        }else if(commitInfo == null){
	        	resultcommit.put("resultval", "0");
	        }
	        
	        return resultcommit;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultcommit;
	}
	
	private static SVNCommitInfo modifyFile(ISVNEditor editor, String dirPath, String filePath, byte[] oldData, byte[] newData) throws SVNException {
        editor.openRoot(-1);
        editor.openDir(dirPath, -1);
        editor.openFile(filePath, -1);
        editor.applyTextDelta(filePath, null);
        
        SVNDeltaGenerator deltaGenerator = new SVNDeltaGenerator();
        String checksum = deltaGenerator.sendDelta(filePath, new ByteArrayInputStream(oldData), 0, new ByteArrayInputStream(newData), editor, true);

        editor.closeFile(filePath, checksum);
        editor.closeDir();

        return editor.closeEdit();
    }
	
	public Map<String, Object> docommitdelete(String repourl, String deletepath, String commitlog){
		Map<String, Object>resultcommit = new HashMap<String, Object>();
		
		System.out.println("file commit");
		
		System.out.println("repo url: " + repourl);
		System.out.println("commit delete path: " + deletepath);
		System.out.println("commit log: " + commitlog);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			SVNNodeKind nodeKind = repository.checkPath("", -1);

	        if (nodeKind == SVNNodeKind.NONE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "No entry at URL ''{0}''", repourl);
	            throw new SVNException(err);
	        } else if (nodeKind == SVNNodeKind.FILE) {
	            SVNErrorMessage err = SVNErrorMessage.create(SVNErrorCode.UNKNOWN, "Entry at URL ''{0}'' is a file while directory was expected", repourl);
	            throw new SVNException(err);
	        }
	        
	        long latestRevision = repository.getLatestRevision();
	        System.out.println("Repository latest revision (before committing): " + latestRevision);
	        
	        ISVNEditor editor = repository.getCommitEditor(commitlog, null);
	        
	        SVNCommitInfo commitInfo = deleteDir(editor, deletepath);
	        System.out.println("The directory was deleted: " + commitInfo);
	        
	        if(commitInfo != null){
	        	resultcommit.put("resultval", "1");
	        }else if(commitInfo == null){
	        	resultcommit.put("resultval", "0");
	        }
	        
	        return resultcommit;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultcommit.put("resultval", "0");
		}
		
		return resultcommit;
	}
	
	private static SVNCommitInfo deleteDir(ISVNEditor editor, String dirPath) throws SVNException {
        editor.openRoot(-1);
        editor.deleteEntry(dirPath, -1);
        editor.closeDir();
        
        return editor.closeEdit();
    }
	
	public Map<String, Object> doDiff(String repourl, long revesionone, long revesiontwo){
		Map<String, Object>resultdiff = new HashMap<String, Object>();
		
		//System.out.println("repourl: " + repourl + "/ revesionone: " + revesionone + "/ revesiontwo: " + revesiontwo);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			SVNURL svnURL = SVNURL.parseURIEncoded(repourl);

			// Get diffClient.
		    SVNClientManager clientManager = SVNClientManager.newInstance();
		    SVNDiffClient diffClient = clientManager.getDiffClient();
		    
		    // Using diffClient, write the changes by commitId into
		    // byteArrayOutputStream, as unified format.
		    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		    diffClient.doDiff(svnURL, null, SVNRevision.create(revesionone), SVNRevision.create(revesiontwo), SVNDepth.INFINITY, true, byteArrayOutputStream);
			
		    String diffresult = byteArrayOutputStream.toString();
		    
		    resultdiff.put("resultval", diffresult);
		    
	        return resultdiff;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			resultdiff.put("resultval", "0");
		}
		
		return resultdiff;
	}
	
	public Map<String, Object> dolock(String repourl, String lockfilepath){
		Map<String, Object>resultlock = new HashMap<String, Object>();
		
		System.out.println("repourl: " + repourl + "/ filepath: " + lockfilepath);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			//File Lock//
			SVNClientManager clientManager = SVNClientManager.newInstance();
			SVNWCClient wcclient = clientManager.getWCClient();
			
			File lockfilelist[] = new File[1];
			lockfilelist[0] = new File(lockfilepath);
			
			wcclient.doLock(lockfilelist, true, "file lock");
			
			//락 확인//
			String lockPath = lockfilepath;
			SVNLock lock = repository.getLock(lockPath);
			
			if (lock == null) {
                System.out.println(lockfilepath + " isn't lock");
                resultlock.put("resultval", "0");
            }
			
			else if(lock != null){
				System.out.println(lockfilepath + " is lock");
				resultlock.put("resultval", "1");
			}
			
			//resultdiff.put("resultval", "1");
		    
	        return resultlock;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			resultlock.put("resultval", "0");
		}
		
		return resultlock;
	}
	
	public Map<String, Object> dounlock(String repourl, String lockfilepath){
		Map<String, Object>resultunlock = new HashMap<String, Object>();
		
		System.out.println("repourl: " + repourl + "/ filepath: " + lockfilepath);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			//File Lock//
			SVNClientManager clientManager = SVNClientManager.newInstance();
			SVNWCClient wcclient = clientManager.getWCClient();
			
			File lockfilelist[] = new File[1];
			lockfilelist[0] = new File(lockfilepath);
			
			wcclient.doUnlock(lockfilelist, true);
			
			resultunlock.put("resultval", "1");
		    
	        return resultunlock;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			resultunlock.put("resultval", "0");
		}
		
		return resultunlock;
	}
	
	@SuppressWarnings("deprecation")
	public Map<String, Object> dostatus(String repourl, String statuspath){
		Map<String, Object>resultstatus = new HashMap<String, Object>();
		
		System.out.println("repourl: " + repourl + "/ statuspath: " + statuspath);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			// Get StatusClient.
		    SVNClientManager clientManager = SVNClientManager.newInstance();
		    SVNStatusClient statusclient = clientManager.getStatusClient();
		    
		    statushandler.setInit(true);
		    
		    /* parameter :
		     * doStatus(wcPath, isRecursive, isRemote, isReportAll, isIncludeIgnored, isCollectParentExternals, Handler)
		     */
		    statusclient.doStatus(new File(statuspath), false, true, true, true, statushandler);
		    
		    Map<String, Object>resultmap = statushandler.getResult();
		   
		    resultstatus.put("resultval", resultmap);
		  
	        return resultstatus;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			resultstatus.put("resultval", "0");
		}
		
		return resultstatus;
	}
	
	public Map<String, Object> doBlame(String repourl, long startrevesion, long endrevesion){
		Map<String, Object>resultblame = new HashMap<String, Object>();
		
		try {	
			//Get LogClient//
			SVNClientManager clientManager = SVNClientManager.newInstance();
			SVNLogClient logClient = clientManager.getLogClient();
			
			boolean includeMergedRevisions = false;
			
			annotationhandler.setInit(includeMergedRevisions, true, logClient.getOptions());
			
			logClient.doAnnotate(new File(repourl), SVNRevision.UNDEFINED, SVNRevision.create(startrevesion), SVNRevision.create(endrevesion), annotationhandler);
		  
			Map<String, Object>resultmap = annotationhandler.getResult();
			resultblame.put("resultval", resultmap);
			
	        return resultblame;
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			resultblame.put("resultval", "0");
		}
		
		return resultblame;
	}
	
	@SuppressWarnings("deprecation")
	public Map<String, Object> doUpdate(String repourl, String updaterepourl, long updaterevesion){
		Map<String, Object>resultupdate = new HashMap<String, Object>();
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
			SVNClientManager clientManager = SVNClientManager.newInstance();
			SVNUpdateClient updateClient = clientManager.getUpdateClient();
			
			updateClient.setIgnoreExternals( false );
			
			if(updaterevesion == 0){
				System.out.println("latest revesion("+repository.getLatestRevision()+") update");
				
				updateClient.doUpdate(new File(updaterepourl), SVNRevision.create(repository.getLatestRevision()), true);
				
				resultupdate.put("retval", "1");
				resultupdate.put("retmsg", "success update revesion["+repository.getLatestRevision()+"]");
			} else{
				System.out.println(updaterevesion + " revesion update");
				
				updateClient.doUpdate(new File(updaterepourl), SVNRevision.create(updaterevesion), true);
				
				resultupdate.put("retval", "1");
				resultupdate.put("retmsg", "success update revesion["+updaterevesion+"]");
			} 
		}catch(SVNException e){
			e.printStackTrace();
			System.out.println(e.getMessage());
			
			resultupdate.put("retval", "0");
			resultupdate.put("retmsg", e.getMessage());
		}
		
		return resultupdate;
	}
	
	@SuppressWarnings("deprecation")
	public Map<String, Object> doCommit(String commitrepourl, String commitmessage){
		Map<String, Object>resultcommit = new HashMap<String, Object>();
		
		//System.out.println("commit path: " + commitrepourl + " / commit message: " + commitmessage);
		SVNClientManager clientManager = SVNClientManager.newInstance();
		SVNCommitClient commitclient = clientManager.getCommitClient();
		
		try{
			File commitfilelist[] = new File[1];
			commitfilelist[0] = new File(commitrepourl);
			
			commitclient.doCommit(commitfilelist, false, commitmessage, false, true);
			
			resultcommit.put("retval", "1");
			resultcommit.put("retmsg", "success commit [" + commitmessage + "]");
		} catch(SVNException e){
			e.printStackTrace();
			resultcommit.put("retval", "0");
			resultcommit.put("retmsg", e.getMessage());
		}
		
		return resultcommit;
	}
	
	@SuppressWarnings("deprecation")
	public Map<String, Object> doCheckout(String checkoutrepourl, String checkoutlocalpath, long checkoutrevesionone, long checkoutrevesiontwo){
		Map<String, Object>resultcheckout = new HashMap<String, Object>();
		
		//System.out.println("checkout url: " + checkoutrepourl + " / checkoutpath: " + checkoutlocalpath + " / " + checkoutrevesionone + " / " + checkoutrevesiontwo);
		SVNClientManager clientManager = SVNClientManager.newInstance();
		SVNUpdateClient updateClient = clientManager.getUpdateClient();
		
		try{
			SVNURL svnURL = SVNURL.parseURIEncoded(checkoutrepourl);
			
			updateClient.setIgnoreExternals( false );
			updateClient.doCheckout(svnURL, new File(checkoutlocalpath), SVNRevision.UNDEFINED, SVNRevision.create(checkoutrevesionone), true, false);
			
			resultcheckout.put("retval", "1");
			resultcheckout.put("retmsg", "success checkout");
		} catch(SVNException e){
			e.printStackTrace();
			
			resultcheckout.put("retval", "0");
			resultcheckout.put("retmsg", e.getMessage());
		}
		
		return resultcheckout;
	}
}
