import { LOCATION_CHANGE } from 'connected-react-router';
import { call, cancel, put, take, takeLatest } from 'redux-saga/effects';
import request from 'utils/request';
import { FETCH_FEEDS_REQUEST } from './constants';
import { fetchFeeds, fetchFeedsError } from './actions';

// Individual exports for testing
export default function* feedsPageSaga() {
  // See example in containers/HomePage/saga.js
}

export function* getFeeds() {
  console.log("GETTIN FEEDS");
  const requestURL = 'http://phxfeeds.api.localhost:4000/api/feeds';

  try {
    const feeds = yield call(request, requestURL);
    yield put(fetchFeeds(feeds));
  } catch (err) {
    yield put(fetchFeedsError(err));
  }
}

export function* watchGetFeeds() {
  const watcher = yield takeLatest(FETCH_FEEDS_REQUEST, getFeeds);

  yield take(LOCATION_CHANGE);
  yield cancel(watcher);
}
