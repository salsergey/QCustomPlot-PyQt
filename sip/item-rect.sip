/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemRect : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <QCustomPlot/src/items/item-rect.h>
%End
public:
  explicit QCPItemRect(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemRect();
  
  // getters:
  QPen pen() const;
  QPen selectedPen() const;
  QBrush brush() const;
  QBrush selectedBrush() const;
  
  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  void setBrush(const QBrush &brush);
  void setSelectedBrush(const QBrush &brush);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  QCPItemPosition * topLeft /NoSetter/;
  QCPItemPosition * bottomRight /NoSetter/;
  QCPItemAnchor * top /NoSetter/;
  QCPItemAnchor * topRight /NoSetter/;
  QCPItemAnchor * right /NoSetter/;
  QCPItemAnchor * bottom /NoSetter/;
  QCPItemAnchor * bottomLeft /NoSetter/;
  QCPItemAnchor * left /NoSetter/;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual QPointF anchorPixelPosition(int anchorId) const;

  // non-virtual methods:
  QPen mainPen() const;
  QBrush mainBrush() const;
};
