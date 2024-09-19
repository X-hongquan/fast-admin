/**
 * 工作方式字典
 */
export const job_info$job_typeMap = {
  1: 'fixed_rate',
  2: 'cron'
}
/**
 * 触发状态字典
 */
export const job_info$trigger_statusMap = {
  1: '运行',
  0: '停止'
}
/**
 * 处理状态字典
 */
export const job_log$handle_statusMap = {
  1: '成功',
  0: '失败'
}
/**
 * 菜单类型字典
 */
export const menu$typeMap = {
  0: '目录',
  1: '菜单',
  2: '其他'
}
/**
 * 状态字典
 */
export const menu$statusMap = {
  1: '正常',
  0: '禁用'
}
/**
 * 是否外链字典
 */
export const menu$linkMap = {
  0: '非外链',
  1: '外链'
}
/**
 * 业务类型字典
 */
export const operation_log$business_typeMap = {
  1: '其它',
  2: '新增',
  3: '更改',
  4: '删除',
  5: '授权',
  6: '导出',
  7: '导入',
  8: '强退'
}
/**
 * 操作类别字典
 */
export const operation_log$operator_typeMap = {
  1: '后台用户',
  2: '其他',
  3: '手机端用户'
}
/**
 * 操作状态字典
 */
export const operation_log$statusMap = {
  1: '正常',
  0: '异常'
}
/**
 * 性别字典
 */
export const user$genderMap = {
  1: '男',
  2: '女',
  3: '其它'
}
/**
 * 状态字典
 */
export const user$statusMap = {
  1: '正常',
  0: '禁用'
}
