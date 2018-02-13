import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateCashbackComponent } from './create-cashback.component';

describe('CreateCashbackComponent', () => {
  let component: CreateCashbackComponent;
  let fixture: ComponentFixture<CreateCashbackComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CreateCashbackComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CreateCashbackComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
