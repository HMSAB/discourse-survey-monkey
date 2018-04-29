//import { default as computed } from 'ember-addons/ember-computed-decorators';
import { ajax } from 'discourse/lib/ajax';
import { popupAjaxError } from 'discourse/lib/ajax-error';

export default Ember.Controller.extend({
  actions: {
    sendSurvey(){
      let path = '/surveymonkey/send_survey';

      return ajax(path, {
        type: 'POST',
        data: { topic_id: this.get('model.topic_id')}
      }).then(() => {
        window.location.reload(true);
      }).catch(popupAjaxError);
    }
  }
});
