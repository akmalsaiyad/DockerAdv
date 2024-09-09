package com.nagarro.docker.adv.app.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DockerAdvController {
	
	@GetMapping(value="/app")
	public String StartApp() {
		return "Hello World";
	}

}
