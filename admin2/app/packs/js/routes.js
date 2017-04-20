import Nodes from './controllers/nodes.js'
import Assets from './controllers/assets.js'
import Users from './controllers/users.js'

export default [
  { path: '/', redirect: { name: 'nodes' } },

  { path: '/nodes',                     name: 'nodes',          component: Nodes.Index },
  { path: '/nodes/new',                 name: 'new_node',       component: Nodes.New },
  { path: '/nodes/:id/edit',            name: 'edit_node',      component: Nodes.Edit,  props: true },
  { path: '/nodes/:node_id/nodes',      name: 'node_nodes',     component: Nodes.Index, props: true },
  { path: '/nodes/:node_id/nodes/new',  name: 'new_node_node',  component: Nodes.New,   props: true },

  { path: '/media',           name: 'assets',     component: Assets.Index },
  { path: '/media/new',       name: 'new_asset',  component: Assets.New },
  { path: '/media/:id/edit',  name: 'edit_asset', component: Assets.Edit, props: true },

  { path: '/users',           name: 'users',      component: Users.Index },
  { path: '/users/new',       name: 'new_user',   component: Users.New },
  { path: '/users/:id/edit',  name: 'edit_user',  component: Users.Edit, props: true }
]