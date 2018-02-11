var request = require('request');

function foo(activeSprintId, endDate, sprintName) 
{		
		var inprog_issues = [];
		var closed_issues = [];
		var todo_issues = [];		
		
		request({
			url: 'https://dashing-mock-api.herokuapp.com/issues',
	        headers: {
	            'Cache-Control': 'no-cache, no-store, must-revalidate',
	            'Pragma': 'no-cache'
	        }
	    }, function(error, response, body) {
	        if (error || typeof response === 'undefined'){
				//api access error
			} 
			else if(response.statusCode != 200) {	    
				//api access was not sucessful
	        } else {				
	        	var closedIssueCount = 0;
				var totalNoIssues = 0;
	        	var issues = JSON.parse(body)//.issues;
				
				for (var i = 0, len = issues.length; i < len; i++) {
					{
						totalNoIssues++;
					}
				}
					
				console.log("issues.length " + issues.length);
	     	    for (var i = 0, len = issues.length; i < len; i++) {
					{					
						if(issues[i].fields.status.statusCategory.id == 4) {//in progress
							inprog_issues.push({
							 id: issues[i].key,
							 title: issues[i].fields.summary,
							 assigneeName: issues[i].fields.assignee.displayName,							 							 
							 assigneeAvatarUrl: issues[i].fields.assignee.avatarUrls['48x48']
							});
						}
						else if(issues[i].fields.status.statusCategory.id == 3) {//closed
							closedIssueCount++;						
							
							closed_issues.push({
							 id: issues[i].key,
							 title: issues[i].fields.summary,
							 assigneeName: issues[i].fields.assignee.displayName,							 							 							 
							 assigneeAvatarUrl: issues[i].fields.assignee.avatarUrls['48x48']							 
							});
						}	
						else {//todo
							todo_issues.push({
							 id: issues[i].key,
							 title: issues[i].fields.summary,
							 assigneeName: issues[i].fields.assignee.displayName,
							 assigneeAvatarUrl: issues[i].fields.assignee.avatarUrls['48x48']
							});
						}
					}
	     	    }
	        	
				send_event('jira-in-prog-issues', { header: sprintName, issue_type: 'IN PROGRESS', issues: inprog_issues});
				send_event('jira-closed-issues', { header: sprintName, issue_type: 'CLOSED', issues: closed_issues});
				send_event('jira-todo-issues', { header: sprintName, issue_type: 'TO DO', issues: todo_issues});
																
	     	    //this.endDate = endDate;
	        	this.activeSprintId = activeSprintId;
	        	this.totalNoIssues = totalNoIssues;
	        	this.closedIssueCount = closedIssueCount;
	        	this.closePercentage = Math.ceil(this.closedIssueCount / this.totalNoIssues * 100);
	        	
	        	
				/*
				send_event('sprintcountdown', {
					title: 'time left',
					end: this.endDate + ' 17:30:00'
				});*/
				/*
				send_event('sprint-progress', { 				
					value: this.closePercentage,
					moreinfo: ' ' + this.closedIssueCount + ' / ' + this.totalNoIssues }
				)*/
				send_event('sprint-progress', { 				
					value: 60,
					moreinfo: ' 30 / 50' }
				);
	        }
	    })
	}

function main() {
	foo(1,1,'Sprint 12');
}
setInterval(main, 35000);  
main();