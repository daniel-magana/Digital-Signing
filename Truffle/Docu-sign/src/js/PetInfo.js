import React, { Component } from "react";


class PetInfo extends Component {
    constructor(){
        super();
    }
    
    render(){
        flag = false;
        if(this.props.adopted !== '0x0000000000000000000000000000000000000000'){
            flag = true;
        }


        return(
            <div style="display: none;">
                <div className="col-sm-6 col-md-4 col-lg-3">
                    <div className="panel panel-default panel-pet">
                        <div className="panel-heading">
                            <h3 className="panel-title">{this.props.petInfo.name} </h3>
                        </div>
                        <div className="panel-body">
                            <img alt="140x140" data-src="holder.js/140x140" className="img-rounded img-center" style="width: 100%;" src={this.props.petInfo.picture} data-holder-rendered="true"/>
                            <br/><br/>
                            <strong>Breed</strong>: <span className="pet-breed">{this.props.petInfo.breed}</span><br/>
                            <strong>Age</strong>: <span className="pet-age">{this.props.petInfo.age}</span><br/>
                            <strong>Location</strong>: <span className="pet-location">{this.props.petInfo.location}</span><br/><br/>
                            <button disabled={flag} className="btn btn-default btn-adopt" type="button" data-id={this.props.petInfo.id}>Adopt</button>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default PetInfo;