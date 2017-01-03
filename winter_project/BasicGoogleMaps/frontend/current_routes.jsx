import React from 'react';
import ReactDOM from 'react-dom';

class currentRoutes extends React.Component {
  constructor() {
    super();
    this.state = { routes: {} };
  }

  componentDidMount() {

    $.ajax({
      method: "GET",
      url: `/users/{current_user}`,
      dataType: 'json',
      success: rout => this.setState(routes: rout)
    });
  }

  render() {
    return (
      <ul>
        this.state.routes.map( (route) => {
          <li>{route}</li>
        });
      </ul>
    );
  }
}

export default currentRoutes;
