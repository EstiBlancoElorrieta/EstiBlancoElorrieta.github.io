

function tabSwitch(new_tab, new_content) {
     
    document.getElementById('content_1').style.display = 'none';
    document.getElementById('content_2').style.display = 'none';
    document.getElementById('content_3').style.display = 'none';  
    document.getElementById('content_4').style.display = 'none';        

    document.getElementById(new_content).style.display = 'block';   
     
 
    document.getElementById('tab_1').className = '';
    document.getElementById('tab_2').className = '';
    document.getElementById('tab_3').className = ''; 
    document.getElementById('tab_4').className = '';    
    document.getElementById(new_tab).className = 'active';      
 
}

  document.getElementById(new_tab).className = 'active';      
  
 }
-var url = document.location.toString();
-if (url.match('#')) {
-    $('.nav-tabs a[href=#'+url.split('#')[1]+']').tab('show') ;
+var hash = document.location.hash;
+var prefix = "tab_";
+if (hash) {
+    $('.nav-tabs a[href='+hash.replace(prefix,"")+']').tab('show');
 } 
 
 // Change hash for page-reload
-$('.nav-tabs a').on('shown.bs.tab', function (e) {
-    window.location.hash = e.target.hash;
-})
+$('.nav-tabs a').on('shown', function (e) {
+    window.location.hash = e.target.hash.replace("#", "#" + prefix);
+});
