// 你自己的包名
package com.chq.app.config;

import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.media.StringSchema;

import io.swagger.v3.oas.models.parameters.HeaderParameter;
import org.springdoc.core.customizers.OpenApiCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Author HHHY
 * @ClassName
 * @Date: 2024/4/2 14:21
 * @Description: Swagger 配置
 */

@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI springShopOpenAPI() {
        return new OpenAPI()
                .info(new Info().title("hq-admin restful API")
                        .contact(new Contact())
                        .description("hq-admin的 rest API")
                        .version("v3.0.0")
                        .license(new License().name("Apache 2.0").url("http://springdoc.org")))
                        .externalDocs(new ExternalDocumentation()
                        .description("外部文档")
                        .url("https://springshop.wiki.github.org/docs"));
    }

    @Bean
    public OpenApiCustomizer customerGlobalHeaderOpenApiCustomiser() {
        return openApi -> {
            openApi.getPaths().values().forEach(pathItem -> pathItem.readOperations().forEach(operation -> {
                HeaderParameter headerParameter = (HeaderParameter) new HeaderParameter()
                        .name("Authorization")
                        .description("认证头")
                        .required(true)
                        .schema(new StringSchema());
                operation.addParametersItem(headerParameter);
            }));
        };
    }
}
