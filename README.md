# SVN Test (ver 1.7)
<div>
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/svnicon.png" width="50" height="50">&nbsp
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/svnkiticon.png" width="100" height="50">&nbsp
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/springicon.png" width="50" height="50">&nbsp
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/springsecurityicon.png" width="50" height="50">&nbsp
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/mongodbicon.png" width="50" height="50">&nbsp
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/tortoisesvnicon.png" width="55" height="55">
<div>
<div>
<h1><label>$ SVN (Spring Framework)</label>
</div>
</h1>
</div>
<div>
<h2><label># refrence site address</label></h2>
<li>https://github.com/hudson/svnkit/tree/master/doc/examples/src/org/tmatesoft/svn/examples</li>
<li>https://svnkit.com/</li>
<li>https://svnkit.com/javadoc/index.html</li>
<li>https://wiki.svnkit.com/</li>
<li>https://github.com/ndeloof/svnkit/tree/master/svnkit-dav</li>
<li>https://logback.qos.ch/index.html</li>
<li>https://tortoisesvn.net/</li>
</div>
<br>
<div>
<h2><label># Subversion architecture</label></h2>
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitScreenshot/screenshot_3_architecture.png" width="600" height="600">
</div>
<br>
<div>
<h2><label># Big Picture</label></h2>
<img src="https://github.com/seochangwook/forweaver.dev-SVN-FTP/blob/master/gitScreenshot/screenshot_1_bigpicture.png" width="800" height="500">
</div>
<br>
<div>
<h2><label># function test list</label></h2>
<h3><label>* SVNKit (Client)</label></h3>
<li>make repository</li>
<li>repository info view</li>
<li>repository history view</li>
<li>repository tree view</li>
<li>file content view</li>
<li>add file and directory</li>
<li>modify file</li>
<li>delete file</li>
<li>code Syntax Beautiful</li>
<li>Separate files and directories with images</li>
<li>file download</li>
<li>Authentication</li>
<li>diff (Revision Differences), (Window path issue -> modifying)
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/fixicon.png" width="30" height="30">
</li>
<li>Lock & UnLock (SVNClient(Tortoisesvn) & Subversion  version issue -> pending)
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/warning.png" width="30" height="30">
</li>
<li>Status</li>
<li>Blame (file modifier by file line), (Window path issue -> modifying)
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitimage/fixicon.png" width="30" height="30">
</li>
<li>Update</li>
<li>Commit</li>
<li>Checkout</li>
<li>Import</li>
</div>
<br>
<h3><label>* SVNKit-dav (Server)</label></h3>
<li>SVN command learn</li>
<li>Login Auth System - Spring Security(crypto-SHA) & MongoDB</li>
<li>DAV-Servlet - Spring Security(Basic Login)</li>
<li>Logback - Server Log Print & Save Local File</li>
<br>
<h3><label>* Additional service</label></h3>
<li>Chatting (WebSocket)</li>
<br>
<h2><label># OpenSource Copyright</label></h2>
<li>SVNKit : copyright © 2004-2017, tmate software</li>
<br>
<h2><label># Test method</label></h2>
<li>Client Method : TotoiseSVN (Window), Terminal (Linux, Mac) & SVNKit View (after forweaver)</li>
<li>Server Method : SVNKitDAV Servlet</li><br>
<img src="https://raw.githubusercontent.com/seochangwook/forweaver.dev-SVN/master/gitScreenshot/screenshot_2_teststructure.png" width="800" height="500">
