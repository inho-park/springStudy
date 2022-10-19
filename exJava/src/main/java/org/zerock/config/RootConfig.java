package org.zerock.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages= {"org.zerock.sample"})
public class RootConfig {
	
	@Bean
	public DataSource dataSource() {
		HikariConfig hikariconfig = new HikariConfig();
		hikariconfig.setDriverClassName("oracle.jdbc.driver.OracleDriver");
		hikariconfig.setJdbcUrl("jdbc:oracle:thin:@localhost:1522:XE");
		hikariconfig.setUsername("scott");
		hikariconfig.setPassword("tiger");
		
		DataSource dataSource = new HikariDataSource(hikariconfig);
		
		return dataSource;
	}
}
