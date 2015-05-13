import Ember from 'ember';
import request from 'ic-ajax';

export default Ember.Route.extend({
  queryParams: {
    query: { refreshModel: true }
  },
  model(params) {
    return request('http://localhost:4200/api/search?query=' + params.query);
  }
});
