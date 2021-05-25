package com.gd.sakila.controller;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
/*
 * DB에 엑세스하는 여러 연산을 하나의 트랜잭션으로 처리하여 오류가 발생한 경우 롤백을 도와주는것
 * (timeout=초)단위로 시간을 정할수도 있다
 */
@Controller
/*
 *  * 스프링의 component-scanning 기술이 이 클래스를 어플리케이션 컨텍스트에 빈으로 등록하게 되는 
 * @Component = 어노테이션을 사용해도 상관없다.
 * 하지만, @Controller 어노테이션을 사용함으로써 @RequestMapping 등의 추가적인 어노테이션을 사용할 수 있게 된다.
 * 
- 컨트롤러 객체임을 명시. Classpath 스캔을 통해 자동으로 감지된다.


실제 프로젝트에서 @Component가 필요한 비슷한 상황들을 직면하곤 한다.
하지만, 대부분의 상황에서 우리는 @Repository, @Service, @Controller 어노테이션을 사용하는게 좋다.
@Component 어노테이션은 Controller, Service, Dao 세가지 카테고리 이외의 클래스에만 사용해야 한다. ???
 */
public class CustomerController {

}
