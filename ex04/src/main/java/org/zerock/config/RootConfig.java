package org.zerock.config;

//import javax.sql.DataSource;
//
//import org.apache.ibatis.session.SqlSessionFactory;
//import org.mybatis.spring.SqlSessionFactoryBean;
//import org.mybatis.spring.annotation.MapperScan;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.EnableAspectJAutoProxy;
//import org.springframework.jdbc.datasource.DataSourceTransactionManager;
//import org.springframework.transaction.annotation.EnableTransactionManagement;
//
//import com.zaxxer.hikari.HikariConfig;
//import com.zaxxer.hikari.HikariDataSource;
//
//@Configuration
//@ComponentScan(basePackages = {"org.zerock.service"})
//@ComponentScan(basePackages = "org.zerock.aop")
//
//@EnableAspectJAutoProxy // = aop:aspectj-autoproxy
//@EnableTransactionManagement // = tx:annotation-driven
//
//@MapperScan(basePackages = {"org.zerock.mapper"}) // = mybatis-spring:scan base-package="org.zerock.mapper"
public class RootConfig {
	
//	@Bean
//	public DataSource dataSource() {
//		HikariConfig config = new HikariConfig();
//		config.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
//		config.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1522:XE");
//		config.setUsername("scott");
//		config.setPassword("tiger");
//		HikariDataSource dataSource = new HikariDataSource(config);
//		
//		return dataSource;
//	}
//	
//	@Bean
//	public SqlSessionFactory sqlSessionFactory() throws Exception {
//		SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
//		factory.setDataSource(dataSource());
//		return (SqlSessionFactory)factory.getObject();
//	}
//	
//	@Bean
//	public DataSourceTransactionManager txManager() {
//		return new DataSourceTransactionManager(dataSource());
//	}
}
