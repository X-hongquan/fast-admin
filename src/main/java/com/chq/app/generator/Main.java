package com.chq.app.generator;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException {
        GenerateResource generateResource = new GenerateResource();
        generateResource.create();
        ControllerBuilder controllerBuilder = new ControllerBuilder();
        controllerBuilder.buildTS();


    }
}
