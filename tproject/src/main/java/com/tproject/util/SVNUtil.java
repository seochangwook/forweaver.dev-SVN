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

import org.springframework.stereotype.Component;
import org.tmatesoft.svn.core.SVNCommitInfo;
import org.tmatesoft.svn.core.SVNDirEntry;
import org.tmatesoft.svn.core.SVNErrorCode;
import org.tmatesoft.svn.core.SVNErrorMessage;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;
import org.tmatesoft.svn.core.SVNNodeKind;
import org.tmatesoft.svn.core.SVNProperties;
import org.tmatesoft.svn.core.SVNProperty;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.internal.io.fs.FSRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.svn.SVNRepositoryFactoryImpl;
import org.tmatesoft.svn.core.io.ISVNEditor;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.io.diff.SVNDeltaGenerator;
import org.tmatesoft.svn.core.wc.admin.SVNAdminClient;

@Component
public class SVNUtil {
	private static int totalrepotreecount = 0; //�옱洹��샇異쒖씠�씪 �젙�쟻 硫ㅻ쾭蹂��닔濡� �븘�슂//
	private static List<Object>repotreelist_name;
	private static List<Object>repotreelist_author;
	private static List<Object>repotreelist_revesion;
	private static List<Object>repotreelist_date;
	private static List<Object>repotreelist_lock;
	private static List<Object>repotreelist_kind;
	private static List<Object>repotreelist_commitmessage;
	
	public String doMakeRepo(String repourl){
		String tgtPath = repourl;
		
		try {
			SVNURL tgtURL = SVNRepositoryFactory.createLocalRepository( new File( tgtPath ), true , false );
			
			return tgtURL.toString();
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public Map<String, Object> doPrintRepo(String repourl){
		Map<String, Object> repoinfomap = new HashMap<String,Object>();
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create( SVNURL.parseURIEncoded(repourl));
			
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
	
	public Map<String, Object> doPrintRepoLog(String repourl){
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
	
	public Map<String, Object> doPrintRepotree(String repourl){
		Map<String, Object>repotreelistinfo = new HashMap<String, Object>();
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
			
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
			
			
			listEntries(repository, ""); //由ъ뒪�듃瑜� �젙蹂대�� 異붽�//
			
			repotreelistinfo.put("listcount", totalrepotreecount);
			repotreelistinfo.put("repotreelistname", repotreelist_name);
			repotreelistinfo.put("repotreelistauthor", repotreelist_author);
			repotreelistinfo.put("repotreelistrevesion", repotreelist_revesion);
			repotreelistinfo.put("repotreelistdate", repotreelist_date);
			repotreelistinfo.put("repotreelistlock", repotreelist_lock);
			repotreelistinfo.put("repokind", repotreelist_kind);
			repotreelistinfo.put("repocommitmsg", repotreelist_commitmessage);
			
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
        
            repptreecount++;
            
            //재귀적으로 호출 시 하위구조의 정보까지 출력된다.//
            /*if (entry.getKind() == SVNNodeKind.DIR) {
            	//���옣�냼媛� �뵒�젆�꽣由ъ씠硫� Depth�븯�굹瑜� �뜑 �뱾�뼱媛��빞吏� �뙆�씪�씠 �엳湲곗뿉 listEntries瑜� �옱洹��샇異쒗븳�떎.//
                listEntries(repository, (path.equals("")) ? entry.getName() : path + "/" + entry.getName());
            }*/
        }
        
        totalrepotreecount += repptreecount;
    }
	
	public Map<String,Object> doPrintFilecontent(String repourl, String filename, String filepath){
		Map<String, Object>filecontentinfo = new HashMap<String, Object>();
		String filecontent = "";
		
		System.out.println("file content view");
		
		System.out.println("repo url: " + repourl);
		System.out.println("file name: " + filename);
		System.out.println("file path: " + filepath);
		
		SVNRepository repository = null;
		
		try {
			repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(repourl));
		
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
	
	public Map<String, Object> docommit(String repourl, String commitpath, String commitlog, String commitfilename, String commitfilecontent){
		Map<String, Object>resultcommit = new HashMap<String, Object>();
		
		System.out.println("file commit");
		
		System.out.println("repo url: " + repourl);
		System.out.println("commit path: " + commitpath);
		System.out.println("commit log: " + commitlog);
		System.out.println("commit filename: " + commitfilename);
		System.out.println("commit filecontent: " + commitfilecontent);
		
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
	
	public void docommitmodify(String repourl, String commitpath, String commitlog, String commitfilename, String originalcontent, String updatecontent){
		Map<String, Object>resultcommit = new HashMap<String, Object>();
		
		System.out.println("file commit");
		
		System.out.println("repo url: " + repourl);
		System.out.println("commit path: " + commitpath);
		System.out.println("commit log: " + commitlog);
		System.out.println("commit filename: " + commitfilename);
		System.out.println("commit filecontent: " + originalcontent);
		System.out.println("update content:" + updatecontent);
		
		
	}
}
