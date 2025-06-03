/*
 * Copyright 2025 Sawyerlsy
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info   */
/******************************************/
CREATE TABLE "config_info" (
                               "id" BIGINT IDENTITY(1,1) NOT NULL,
                               "data_id" VARCHAR(255) NOT NULL,
                               "group_id" VARCHAR(128),
                               "content" CLOB NOT NULL,
                               "md5" VARCHAR(32),
                               "gmt_create" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                               "gmt_modified" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                               "src_user" CLOB,
                               "src_ip" VARCHAR(50),
                               "app_name" VARCHAR(128),
                               "tenant_id" VARCHAR(128) DEFAULT NULL,
                               "c_desc" VARCHAR(256),
                               "c_use" VARCHAR(64),
                               "effect" VARCHAR(64),
                               "type" VARCHAR(64),
                               "c_schema" CLOB,
                               "encrypted_data_key" CLOB,
                               PRIMARY KEY ("id"),
                               CONSTRAINT "uk_configinfo_datagrouptenant" UNIQUE ("data_id","group_id","tenant_id")
) ;

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_aggr   */
/******************************************/
CREATE TABLE "config_info_aggr" (
                                    "id" BIGINT IDENTITY(1,1) NOT NULL,
                                    "data_id" VARCHAR(255) NOT NULL,
                                    "group_id" VARCHAR(128) NOT NULL,
                                    "datum_id" VARCHAR(255) NOT NULL,
                                    "content" CLOB NOT NULL,
                                    "gmt_modified" DATETIME NOT NULL,
                                    "app_name" VARCHAR(128),
                                    "tenant_id" VARCHAR(128) DEFAULT NULL,
                                    PRIMARY KEY ("id"),
                                    CONSTRAINT "uk_configinfoaggr_datagrouptenantdatum" UNIQUE ("data_id","group_id","tenant_id","datum_id")
) ;

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_beta   */
/******************************************/
CREATE TABLE "config_info_beta" (
                                    "id" BIGINT IDENTITY(1,1) NOT NULL,
                                    "data_id" VARCHAR(255) NOT NULL,
                                    "group_id" VARCHAR(128) NOT NULL,
                                    "app_name" VARCHAR(128),
                                    "content" CLOB NOT NULL,
                                    "beta_ips" VARCHAR(1024),
                                    "md5" VARCHAR(32),
                                    "gmt_create" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                    "gmt_modified" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                    "src_user" CLOB,
                                    "src_ip" VARCHAR(50),
                                    "tenant_id" VARCHAR(128) DEFAULT NULL,
                                    "encrypted_data_key" CLOB,
                                    PRIMARY KEY ("id"),
                                    CONSTRAINT "uk_configinfobeta_datagrouptenant" UNIQUE ("data_id","group_id","tenant_id")
) ;

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_tag   */
/******************************************/
CREATE TABLE "config_info_tag" (
                                   "id" BIGINT IDENTITY(1,1) NOT NULL,
                                   "data_id" VARCHAR(255) NOT NULL,
                                   "group_id" VARCHAR(128) NOT NULL,
                                   "tenant_id" VARCHAR(128) DEFAULT NULL,
                                   "tag_id" VARCHAR(128) NOT NULL,
                                   "app_name" VARCHAR(128),
                                   "content" CLOB NOT NULL,
                                   "md5" VARCHAR(32),
                                   "gmt_create" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                   "gmt_modified" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                   "src_user" CLOB,
                                   "src_ip" VARCHAR(50),
                                   PRIMARY KEY ("id"),
                                   CONSTRAINT "uk_configinfotag_datagrouptenanttag" UNIQUE ("data_id","group_id","tenant_id","tag_id")
) ;

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_tags_relation   */
/******************************************/
CREATE TABLE "config_tags_relation" (
                                        "id" BIGINT NOT NULL,
                                        "tag_name" VARCHAR(128) NOT NULL,
                                        "tag_type" VARCHAR(64),
                                        "data_id" VARCHAR(255) NOT NULL,
                                        "group_id" VARCHAR(128) NOT NULL,
                                        "tenant_id" VARCHAR(128) DEFAULT NULL,
                                        "nid" BIGINT IDENTITY(1,1) NOT NULL,
                                        PRIMARY KEY ("nid"),
                                        CONSTRAINT "uk_configtagrelation_configidtag" UNIQUE ("id","tag_name","tag_type")
) ;
CREATE INDEX "idx_configtagrelation_tenant_id" ON "config_tags_relation"("tenant_id");

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = group_capacity   */
/******************************************/
CREATE TABLE "group_capacity" (
                                  "id" BIGINT IDENTITY(1,1) NOT NULL,
                                  "group_id" VARCHAR(128) NOT NULL DEFAULT NULL,
                                  "quota" INT DEFAULT 0,
                                  "usage" INT DEFAULT 0,
                                  "max_size" INT DEFAULT 0,
                                  "max_aggr_count" INT DEFAULT 0,
                                  "max_aggr_size" INT DEFAULT 0,
                                  "max_history_count" INT DEFAULT 0,
                                  "gmt_create" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                  "gmt_modified" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                  PRIMARY KEY ("id"),
                                  CONSTRAINT "uk_group_id" UNIQUE ("group_id")
) ;

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = his_config_info   */
/******************************************/
CREATE TABLE "his_config_info" (
                                   "id" BIGINT NOT NULL,
                                   "nid" BIGINT IDENTITY(1,1) NOT NULL,
                                   "data_id" VARCHAR(255) NOT NULL,
                                   "group_id" VARCHAR(128) NOT NULL,
                                   "app_name" VARCHAR(128),
                                   "content" CLOB NOT NULL,
                                   "md5" VARCHAR(32),
                                   "gmt_create" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                   "gmt_modified" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                   "src_user" CLOB,
                                   "src_ip" VARCHAR(50),
                                   "op_type" CHAR(10),
                                   "tenant_id" VARCHAR(128) DEFAULT NULL,
                                   "encrypted_data_key" CLOB,
                                   PRIMARY KEY ("nid")
) ;
CREATE INDEX "idx_gmt_create" ON "his_config_info"("gmt_create");
CREATE INDEX "idx_gmt_modified" ON "his_config_info"("gmt_modified");
CREATE INDEX "idx_did" ON "his_config_info"("data_id");

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = tenant_capacity   */
/******************************************/
CREATE TABLE "tenant_capacity" (
                                   "id" BIGINT IDENTITY(1,1) NOT NULL,
                                   "tenant_id" VARCHAR(128) NOT NULL DEFAULT NULL,
                                   "quota" INT DEFAULT 0,
                                   "usage" INT DEFAULT 0,
                                   "max_size" INT DEFAULT 0,
                                   "max_aggr_count" INT DEFAULT 0,
                                   "max_aggr_size" INT DEFAULT 0,
                                   "max_history_count" INT DEFAULT 0,
                                   "gmt_create" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                   "gmt_modified" DATETIME DEFAULT CURRENT_TIMESTAMP(),
                                   PRIMARY KEY ("id"),
                                   CONSTRAINT "uk_tenant_id" UNIQUE ("tenant_id")
) ;

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = tenant_info   */
/******************************************/
CREATE TABLE "tenant_info" (
                               "id" BIGINT IDENTITY(1,1) NOT NULL,
                               "kp" VARCHAR(128) NOT NULL,
                               "tenant_id" VARCHAR(128) DEFAULT NULL,
                               "tenant_name" VARCHAR(128) DEFAULT NULL,
                               "tenant_desc" VARCHAR(256),
                               "create_source" VARCHAR(32),
                               "gmt_create" BIGINT NOT NULL,
                               "gmt_modified" BIGINT NOT NULL,
                               PRIMARY KEY ("id"),
                               CONSTRAINT "uk_tenant_info_kptenantid" UNIQUE ("kp","tenant_id")
) ;
CREATE INDEX "idx_tenant_info_tenant_id" ON "tenant_info"("tenant_id");

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = users   */
/******************************************/
CREATE TABLE "users" (
                         "username" VARCHAR(50) NOT NULL PRIMARY KEY,
                         "password" VARCHAR(500) NOT NULL,
                         "enabled" TINYINT NOT NULL
);

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = roles   */
/******************************************/
CREATE TABLE "roles" (
                         "username" VARCHAR(50) NOT NULL,
                         "role" VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX "idx_user_role" ON "roles"("username", "role");

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = permissions   */
/******************************************/
CREATE TABLE "permissions" (
                               "role" VARCHAR(50) NOT NULL,
                               "resource" VARCHAR(255) NOT NULL,
                               "action" VARCHAR(8) NOT NULL
);
CREATE UNIQUE INDEX "uk_role_permission" ON "permissions"("role","resource","action");

-- 初始化数据
INSERT INTO "users" ("username", "password", "enabled") VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);
INSERT INTO "roles" ("username", "role") VALUES ('nacos', 'ROLE_ADMIN');
