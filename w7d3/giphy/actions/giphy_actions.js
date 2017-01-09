import * as APIUtil from '../util/api_util';

export const RECEIVE_SEARCH_GIPHYS = 'RECEIVE_SEARCH_GIPHYS';

export const receiveSearchGiphys = giphys => ({
    type: RECEIVE_SEARCH_GIPHYS,
    giphys
});

export const fetchSearchGiphys = (searchTerm) => (dispatch) => (
    APIUtil.fetchSearchGiphys(searchTerm).then(res => receiveSearchGiphys(res))
);
