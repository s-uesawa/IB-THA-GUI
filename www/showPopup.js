function showPopup (address, pt) {
        view.popup.open({
          title:  + Math.round(pt.longitude * 100000)/100000 + "," + Math.round(pt.latitude * 100000)/100000,
          content: address,
          location: pt
        });
};
