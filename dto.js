const AppApplication = reactive({
})

const EmailForm = reactive({
	newEmail: undefined,
	code: undefined,
})

const LoginForm = reactive({
	username: undefined,
	password: undefined,
})

const PasswordForm = reactive({
	oldPassword: undefined,
	newPassword: undefined,
	code: undefined,
})

const MessageDto = reactive({
	theme: undefined,
	content: undefined,
	to: undefined,
})

const RoleDto = reactive({
})

const RoleMenuDto = reactive({
	roleId: undefined,
	menuIds: undefined,
})

const RolePermissionDto = reactive({
	roleId: undefined,
	permissionIds: undefined,
})

const GeneratorJsObj = reactive({
})

const Menu = reactive({
	id: undefined,
	name: undefined,
	parentId: undefined,
	component: undefined,
	url: undefined,
	sort: undefined,
	title: undefined,
	level: undefined,
	type: undefined,
	icon: undefined,
	status: undefined,
	redirect: undefined,
	link: undefined,
})

const OperationLog = reactive({
	id: undefined,
	title: undefined,
	businessType: undefined,
	method: undefined,
	requestMethod: undefined,
	operatorType: undefined,
	operationName: undefined,
	operationParam: undefined,
	jsonResult: undefined,
	status: undefined,
	errorMsg: undefined,
	operationTime: undefined,
	costTime: undefined,
})

const Permission = reactive({
	id: undefined,
	code: undefined,
	description: undefined,
})

const Role = reactive({
	id: undefined,
	name: undefined,
})

const RoleMenu = reactive({
	id: undefined,
	roleId: undefined,
	menuId: undefined,
})

const RolePermission = reactive({
	id: undefined,
	roleId: undefined,
	permissionId: undefined,
	permissionCode: undefined,
	roleName: undefined,
})

const Setting = reactive({
	id: undefined,
	permissionMode: undefined,
})

const User = reactive({
	id: undefined,
	username: undefined,
	password: undefined,
	avatar: undefined,
	status: undefined,
	email: undefined,
	roles: undefined,
})

const UserRole = reactive({
	id: undefined,
	userId: undefined,
	roleId: undefined,
})

