import Vue from 'vue'
import TopBar from '../../../app/packs/js/components/top-bar.vue'

function getComponent(component, propsData) {
  const Comp = Vue.extend(component);
  return new Comp({ propsData }).$mount();
}

describe('TopBar', () => {
  it('must display the title', () => {
    let vm = getComponent(TopBar, { title: 'Foo' });
    expect(vm.$el.textContent).toContain('Foo');
  })
})