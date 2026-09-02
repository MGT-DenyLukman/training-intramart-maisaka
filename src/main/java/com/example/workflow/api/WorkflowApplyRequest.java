package com.example.workflow.api;

import java.util.Map;

public class WorkflowApplyRequest {
    private String flowId;
    private String matterName;
	private Map<String, Object> userParam;

    public String getFlowId() { return flowId; }

    public void setFlowId(String flowId) { this.flowId = flowId; }

    public String getMatterName() { return matterName; }

    public void setMatterName(String matterName) { this.matterName = matterName; }

    public Map<String, Object> getUserParam() {
		return userParam;
	}
	public void setUserParam(Map<String, Object> userParam) {
		this.userParam = userParam;
	}
}