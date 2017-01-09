import React, { Component } from 'react';
import GiphysIndex from './giphys_index';

class GiphysSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = { search: "" };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.update = this.update.bind(this);
  }

  update(e) {
    this.setState({search: e.target.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    const newSearch = this.state.search;
    debugger;
    this.props.fetchSearchGiphys(newSearch).then(this.setState({search: ""}));
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label> Search
          <input
            type="text"
            onChange={this.update}
            value={this.state.search}
            />
        </label>

        <button>Submit!</button>
      </form>
    );
  }
}

export default GiphysSearch;
