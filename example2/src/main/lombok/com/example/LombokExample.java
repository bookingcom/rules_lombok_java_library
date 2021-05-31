package com.example;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class LombokExample {
  private final String lastName;

  static {
    log.info("static builder from com.example.LombokExample");
  }
}
