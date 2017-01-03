import React from 'react';
import ReactDOM from 'react-dom';

class Root extends React.Component {
  render() {
    return(
      <div>
        <div className="current-routes">
          <Directions />
        </div>
        <div className="map">
          <Map />
        </div>
        <div className="friend-routes">
          <Directions />
        </div>
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Root/>, document.getElementById('main'));
});
