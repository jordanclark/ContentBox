<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Saerch Box --->
	<div class="small_box">
		<div class="header">
			<img src="#prc.bbroot#/includes/images/search.png" alt="info" width="24" height="24" />Search
		</div>
		<div class="body<cfif len(rc.search)> selected</cfif>">
			<!--- Search Form --->
			#html.startForm(name="htmlSearchForm",action=rc.xehCustomHTML)#
				#html.textField(label="Search:",name="search",class="textfield",size="16",title="Search all content pieces",value=rc.search)#
				<input type="submit" value="Search" class="buttonred" />
				<button class="button" onclick="return to('#event.buildLink(rc.xehCustomHTML)#')">Clear</button>				
			#html.endForm()#
		</div>
	</div>	
</div>
<!--End sidebar-->	
<!--============================Main Column============================-->
<div class="main_column" id="main_column">
	<div class="box">
		<!--- Body Header --->
		<div class="header">
			<img src="#prc.bbroot#/includes/images/html_32.png" alt="customHTML" />
			Custom HTML
		</div>
		<!--- Body --->
		<div class="body">	
		
		<!--- messageBox --->
		#getPlugin("MessageBox").renderit()#
		
		<p>
			These custom HTML options can be used in any layout to easily add any type of HTML assets, snippets, custom css, js, you name it!
			Just call it with the appropriate slug in your BlogBox layout and you are ready to roll with custom HTML in your layouts.
		</p>
		
		<!--- Usage --->
		<div class="infoBar">
			<img src="#prc.bbRoot#/includes/images/info.png" alt="info" />
			To render the Custom HTML snippets use the following in your layouts -> 
			 <em>##bb.customHTML(slug)##</em>;
		</div>
		
		<!--- entryForm --->
		#html.startForm(name="contentForm",action=rc.xehRemoveHTML)#
			#html.hiddenField(name="page",value=rc.page)#
			#html.hiddenField(name="contentID")#
		
			<!--- Content Bar --->
			<div class="contentBar" id="contentBar">
				<!--- Create Butons --->
				<div class="buttonBar">
					<button class="button2" onclick="openRemoteModal('#event.buildLink(rc.xehEditorHTML)#');return false;" title="Create new content entry">Create Content</button>
				</div>
				<!--- Filter Bar --->
				<div class="filterBar">
					<div>
						#html.label(field="entryFilter",content="Quick Filter:",class="inline")#
						#html.textField(name="entryFilter",size="30",class="textfield")#
					</div>
				</div>
			</div>
			
			<!--- Paging --->
			#rc.pagingPlugin.renderit(rc.entriesCount,rc.pagingLink)#
			
			<!--- comments --->
			<table name="entries" id="entries" class="tablesorter" width="98%">
				<thead>
					<tr>
						<th width="200">Title</th>
						<th>Slug</th>
						<th>Description</th>
						<th width="90" class="center {sorter:false}">Actions</th>
					</tr>
				</thead>
				
				<tbody>
					<cfloop array="#rc.entries#" index="entry">
					<tr>
						<td>
							#entry.getTitle()#
						</td>
						<td>
							#entry.getSlug()#
						</td>
						<td>
							#entry.getDescription()#
						</td>
						<td class="center">
							<!--- Edit Command --->
							<a href="javascript:openRemoteModal('#event.buildLink(rc.xehEditorHTML)#',{contentID:'#entry.getContentID()#'});" title="Edit Content"><img src="#prc.bbroot#/includes/images/edit.png" alt="edit" /></a>
							&nbsp;
							<!--- Delete Command --->
							<a title="Delete Entry Permanently" href="javascript:remove('#entry.getContentID()#')" class="confirmIt" data-title="Delete Entry?"><img id="delete_#entry.getContentID()#" src="#prc.bbroot#/includes/images/delete.png" border="0" alt="delete"/></a>
						</td>
					</tr>
					</cfloop>
				</tbody>
			</table>
			
			<!--- Paging --->
			#rc.pagingPlugin.renderit(rc.entriesCount,rc.pagingLink)#
		
		#html.endForm()#
		
		</div>
	</div>
</div>		
<script type="text/javascript">
$(document).ready(function() {
	$contentForm = $("##contentForm");
	$contentForm.find("##entries").tablesorter();
	$contentForm.find("##entryFilter").keyup(function(){
		$.uiTableFilter( $("##entries"), this.value );
	});
});
function remove(recordID){
	if( recordID != null ){
		$('##delete_'+recordID).attr('src','#prc.bbRoot#/includes/images/ajax-spinner.gif');
		$("##contentID").val( recordID );
	}
	//Submit Form
	$contentForm.submit();
}</script>
</cfoutput>