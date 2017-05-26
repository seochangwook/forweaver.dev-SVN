package com.tproject.util;

import java.io.File;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.internal.io.fs.FSRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.svn.SVNRepositoryFactoryImpl;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.admin.SVNAdminClient;

@Component
public class SVNUtil {
	public String doMakeRepo(String repourl){
		System.out.println("repo make(local file://)");
		
		String tgtPath = repourl;
		
		try {
			SVNURL tgtURL = SVNRepositoryFactory.createLocalRepository( new File( tgtPath ), true , false );
			
			System.out.println("repo url: " + tgtURL.toString());
			
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
		
		System.out.println("repo info");
		
		try {
			repository = SVNRepositoryFactory.create( SVNURL.parseURIEncoded(repourl));
			
			String repoUUID = repository.getRepositoryUUID(true).toString();
			String reporevesion = ""+repository.getLatestRevision();
			
			repoinfomap.put("repouuid", repoUUID);
			repoinfomap.put("reporevesion", reporevesion);
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return repoinfomap;
	}
	
	public void doPrintRepoLog(String repourl){
		SVNRepository repository = null;
		Collection logEntries = null;
		
		long startRevision = 0;
		long endRevision = -1; //HEAD (the latest) revision
		
		try {
			repository = SVNRepositoryFactory.create( SVNURL.parseURIEncoded(repourl));
			logEntries = repository.log( new String[] { "" } , null , startRevision , endRevision , true , true );
			
			for ( Iterator entries = logEntries.iterator( ); entries.hasNext( ); ) {
				  SVNLogEntry logEntry = ( SVNLogEntry ) entries.next( );
				  System.out.println( "---------------------------------------------" );
				  System.out.println ("revision: " + logEntry.getRevision( ) );
				  System.out.println( "author: " + logEntry.getAuthor( ) );
				  System.out.println( "date: " + logEntry.getDate( ) );
				  System.out.println( "log message: " + logEntry.getMessage( ) ); 
				  	if ( logEntry.getChangedPaths( ).size( ) > 0 ) {
				  		System.out.println( );
				  		System.out.println( "changed paths:" );
				  		Set changedPathsSet = logEntry.getChangedPaths( ).keySet( );
				  			for ( Iterator changedPaths = changedPathsSet.iterator( ); changedPaths.hasNext( ); ) {
				  				SVNLogEntryPath entryPath = ( SVNLogEntryPath ) logEntry.getChangedPaths( ).get( changedPaths.next( ) );
				  					System.out.println( " "
				  						+ entryPath.getType( )
				  						+ " "
				  						+ entryPath.getPath( )
				  						+ ( ( entryPath.getCopyPath( ) != null ) ? " (from "
				  								+ entryPath.getCopyPath( ) + " revision "
				  								+ entryPath.getCopyRevision( ) + ")" : "" ) );
				  					}
				  		}
				}
		} catch (SVNException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
