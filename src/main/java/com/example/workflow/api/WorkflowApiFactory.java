package com.example.workflow.api;

import jp.co.intra_mart.foundation.web_api_maker.annotation.ProvideFactory;
import jp.co.intra_mart.foundation.web_api_maker.annotation.ProvideService;
import jp.co.intra_mart.foundation.web_api_maker.annotation.WebAPIMaker;

@WebAPIMaker
public class WorkflowApiFactory {

    @ProvideFactory
    public static WorkflowApiFactory getFactory() {
        return new WorkflowApiFactory();
    }

    @ProvideService
    public WorkflowApiService getService() {
        return new WorkflowApiService();
    }
}