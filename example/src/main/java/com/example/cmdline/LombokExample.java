package com.example.cmdline;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class LombokExample {
  private final String name;

  static {
    log.info("static builder");
  }
}
