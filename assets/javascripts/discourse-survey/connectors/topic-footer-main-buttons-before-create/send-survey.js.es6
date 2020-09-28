import showModal from 'discourse/lib/show-modal';
import { ajax } from 'discourse/lib/ajax';

export default {
  shouldRender(args, component) {
    const needsButton = component.currentUser && component.currentUser.get('staff');
    return needsButton && (!component.get('site.mobileView'));
  },

  actions: {
    sendSurvey() {
      const container = Discourse.__container__;
      var model = {
        topic_id: this.topic.id
      }
      let controller = container.lookup('controller:survey');
      controller.set('model', model);
      controller.send('sendSurvey')
    }
  }
};
