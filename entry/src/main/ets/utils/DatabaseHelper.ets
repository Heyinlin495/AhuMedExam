import relationalStore from '@ohos.data.relationalStore'
import { common } from '@kit.AbilityKit'

const DB_NAME: string = 'userDB.db'
const TABLE_USERS: string = 'users'

export class DatabaseHelper {
  private store: relationalStore.RdbStore | null = null

  // 初始化数据库，建表
  async init(context: common.UIAbilityContext): Promise<void> {
    const config: relationalStore.StoreConfig = {
      name: DB_NAME,
      securityLevel: relationalStore.SecurityLevel.S1
    }
    this.store = await relationalStore.getRdbStore(context, config)

    const createSql: string = `CREATE TABLE IF NOT EXISTS ${TABLE_USERS} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL,
      phone TEXT NOT NULL
    )`
    await this.store.executeSql(createSql)
  }

  // 检查用户名是否已存在
  async hasUser(username: string): Promise<boolean> {
    if (!this.store) {
      return false
    }
    const predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(TABLE_USERS)
    predicates.equalTo('username', username)
    const resultSet: relationalStore.ResultSet = await this.store.query(predicates, ['id'])
    const exists: boolean = resultSet.rowCount > 0
    resultSet.close()
    return exists
  }

  // 注册新用户，成功返回 true
  async addUser(username: string, password: string, phone: string): Promise<boolean> {
    if (!this.store) {
      return false
    }
    const exists: boolean = await this.hasUser(username)
    if (exists) {
      return false
    }

    const bucket: relationalStore.ValuesBucket = {
      username: username,
      password: password,
      phone: phone
    }
    await this.store.insert(TABLE_USERS, bucket)
    return true
  }

  // 校验密码，返回 true 表示匹配
  async checkPassword(username: string, password: string): Promise<boolean> {
    if (!this.store) {
      return false
    }
    const predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(TABLE_USERS)
    predicates.equalTo('username', username)
    predicates.equalTo('password', password)
    const resultSet: relationalStore.ResultSet = await this.store.query(predicates, ['id'])
    const ok: boolean = resultSet.rowCount > 0
    resultSet.close()
    return ok
  }

  // 查询用户是否存在（不校验密码）
  async userExists(username: string): Promise<boolean> {
    return this.hasUser(username)
  }

  // 根据用户名查询手机号
  async getPhone(username: string): Promise<string> {
    if (!this.store) {
      return ''
    }
    const predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(TABLE_USERS)
    predicates.equalTo('username', username)
    const resultSet: relationalStore.ResultSet = await this.store.query(predicates, ['phone'])
    if (resultSet.rowCount > 0 && resultSet.goToFirstRow()) {
      const colIndex: number = resultSet.getColumnIndex('phone')
      const phone: string = resultSet.getString(colIndex)
      resultSet.close()
      return phone
    }
    resultSet.close()
    return ''
  }
}

// 全局单例
export const db: DatabaseHelper = new DatabaseHelper()
