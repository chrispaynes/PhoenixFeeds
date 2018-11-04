/**
 *
 * FeedsPage
 *
 */

import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { createStructuredSelector } from 'reselect';
import { compose } from 'redux';

import injectSaga from 'utils/injectSaga';
import injectReducer from 'utils/injectReducer';
import { makeSelectFeedsPage, feeds } from './selectors';
import reducer from './reducer';
import saga from './saga';

/* eslint-disable react/prefer-stateless-function */
export class FeedsPage extends React.PureComponent {
  componentDidMount() {
    console.log('componentDIDMOUNT THIS: ', this);
    // this.props.fetchFeedsRequest();
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.hasNewFeeds) {
      // this.props.fetchFeedsRequest();
    }
  }

  feeder() {
    return [...this.props.feeds].reverse().map(feed => {
      console.log('feed: ', feed);
      return (
        <div key={feed.id}>
          <div style={{ margin: '16px 0' }}>
            <div>
              <h3>{feed.title}</h3>
              <p>{feed.description}</p>
            </div>
          </div>
        </div>
      );
    });
  }

  render() {
    return <p>TEST</p>;
  }
}

FeedsPage.propTypes = {
  fetchFeedsRequest: PropTypes.func,
  hasNewFeeds: PropTypes.bool,
  feeds: PropTypes.func,
};

const mapStateToProps = createStructuredSelector({
  feedsPage: makeSelectFeedsPage(),
  hasNewFeeds: false,
  feeds: feeds(),
});

function mapDispatchToProps(dispatch) {
  return {
    dispatch,
  };
}

const withConnect = connect(
  mapStateToProps,
  mapDispatchToProps,
);

const withReducer = injectReducer({ key: 'feedsPage', reducer });
const withSaga = injectSaga({ key: 'feedsPage', saga });

export default compose(
  withReducer,
  withSaga,
  withConnect,
)(FeedsPage);
